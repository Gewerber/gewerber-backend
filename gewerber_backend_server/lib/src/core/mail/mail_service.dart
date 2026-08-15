import 'package:injectable/injectable.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart' hide Message;

import 'email_template.dart';

/// Sends transactional emails (verification codes) via SMTP.
///
/// The SMTP settings are read from `config/passwords.yaml` under the `smtp*`
/// keys. If `smtpHost` is not configured (e.g. local development), the
/// verification code is only written to the session log so the auth flow keeps
/// working without a mail server.
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
    } on MailerException catch (e) {
      session.log(
        '[MailService] Failed to send ${template.name} to $email: $e',
        level: LogLevel.error,
        exception: e,
      );
    }
  }
}
