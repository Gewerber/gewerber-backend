import 'package:injectable/injectable.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart' hide Message;

import 'email_template.dart';

/// Sends transactional emails via SMTP.
///
/// The SMTP settings are read from `config/passwords.yaml` under the `smtp*`
/// keys. If `smtpHost` is not configured (e.g. local development), the
/// content is only written to the session log so the flows keep working
/// without a mail server.
@singleton
class MailService {
  Future<void> sendVerificationCode(
    Session session, {
    required String email,
    required String verificationCode,
    required EmailTemplate template,
  }) async {
    final passwords = session.passwords;

    final host = passwords['smtpHost'];
    if (host == null || host.isEmpty) {
      session.log(
        '[MailService] SMTP not configured. ${template.name} code for '
        '$email: $verificationCode',
      );
      return;
    }

    final fromAddress = passwords['smtpFromAddress'];
    if (fromAddress == null || fromAddress.isEmpty) {
      session.log(
        '[MailService] smtpFromAddress is not configured, cannot send to $email',
        level: LogLevel.warning,
      );
      return;
    }

    final smtpServer = SmtpServer(
      host,
      port: int.tryParse(passwords['smtpPort'] ?? '') ?? 587,
      username: passwords['smtpUsername'],
      password: passwords['smtpPassword'],
      ssl: passwords['smtpSsl'] == 'true',
    );

    final appName = passwords['smtpFromName'] ?? 'Gewerber';
    final message = Message()
      ..from = Address(fromAddress, appName)
      ..recipients.add(email)
      ..subject = template.renderSubject()
      ..text = template.renderText(
        appName: appName,
        verificationCode: verificationCode,
      )
      ..html = template.renderHtml(
        appName: appName,
        verificationCode: verificationCode,
      );

    try {
      await send(message, smtpServer);
      session.log('[MailService] ${template.name} sent to $email');
    } on Exception catch (e) {
      session.log(
        '[MailService] Failed to send ${template.name} to $email: $e',
        level: LogLevel.error,
        exception: e,
      );
    }
  }

  /// Sends a payment reminder (Zahlungserinnerung/Mahnung) for an invoice.
  ///
  /// Returns `true` if the email was handed over to the SMTP server, or
  /// `false` when SMTP is not configured (the reminder is logged only).
  Future<bool> sendPaymentReminder(
    Session session, {
    required String toEmail,
    required String customerName,
    required String businessName,
    required String invoiceNumber,
    required int level,
    required String formattedAmount,
    required DateTime dueDate,
  }) async {
    final passwords = session.passwords;

    final dueDateText =
        '${dueDate.day.toString().padLeft(2, '0')}.'
        '${dueDate.month.toString().padLeft(2, '0')}.${dueDate.year}';
    final subject = level <= 1
        ? 'Zahlungserinnerung – Rechnung $invoiceNumber'
        : 'Mahnung (Stufe $level) – Rechnung $invoiceNumber';
    final text =
        '''
Sehr geehrte Damen und Herren,

bei der Überprüfung unserer Zahlungseingänge haben wir festgestellt, dass die Rechnung $invoiceNumber über $formattedAmount bislang nicht beglichen wurde.

Fälligkeit: $dueDateText

Wir bitten Sie, den offenen Betrag zeitnah zu überweisen. Sollten Sie die Zahlung bereits veranlasst haben, betrachten Sie dieses Schreiben bitte als gegenstandslos.

Mit freundlichen Grüßen
$businessName
''';

    final host = passwords['smtpHost'];
    if (host == null || host.isEmpty) {
      session.log(
        '[MailService] SMTP not configured. Payment reminder (level $level) '
        'for invoice $invoiceNumber to $toEmail ($customerName).',
      );
      return false;
    }

    final fromAddress = passwords['smtpFromAddress'];
    if (fromAddress == null || fromAddress.isEmpty) {
      session.log(
        '[MailService] smtpFromAddress is not configured, cannot send '
        'reminder to $toEmail',
        level: LogLevel.warning,
      );
      return false;
    }

    final smtpServer = SmtpServer(
      host,
      port: int.tryParse(passwords['smtpPort'] ?? '') ?? 587,
      username: passwords['smtpUsername'],
      password: passwords['smtpPassword'],
      ssl: passwords['smtpSsl'] == 'true',
    );

    final appName = passwords['smtpFromName'] ?? 'Gewerber';
    final message = Message()
      ..from = Address(fromAddress, appName)
      ..recipients.add(toEmail)
      ..subject = subject
      ..text = text;

    try {
      await send(message, smtpServer);
      session.log(
        '[MailService] Payment reminder (level $level) for $invoiceNumber '
        'sent to $toEmail',
      );
      return true;
    } on Exception catch (e) {
      session.log(
        '[MailService] Failed to send payment reminder to $toEmail: $e',
        level: LogLevel.error,
        exception: e,
      );
      return false;
    }
  }
}
