/// Closed set of transactional email templates rendered by [MailService].
///
/// Templates are plain strings composed on the server; no external template
/// engine is involved. Adding a new value is safe, renaming is not.
enum EmailTemplate {
  registrationVerification,
  passwordResetVerification;

  String renderSubject() => switch (this) {
    EmailTemplate.registrationVerification =>
      'Gewerber – E-Mail-Adresse bestätigen',
    EmailTemplate.passwordResetVerification =>
      'Gewerber – Passwort zurücksetzen',
  };

  String renderText({
    required String appName,
    required String verificationCode,
  }) => switch (this) {
    EmailTemplate.registrationVerification =>
      '''
Hallo,

danke, dass du dich bei $appName registriert hast. Dein Bestätigungscode lautet:

$verificationCode

Gib diesen Code in der App ein, um deine E-Mail-Adresse zu bestätigen. Der Code ist 15 Minuten gültig.

Falls du dich nicht registriert hast, kannst du diese E-Mail ignorieren.

– Dein $appName Team''',
    EmailTemplate.passwordResetVerification =>
      '''
Hallo,

du hast eine Passwort-Zurücksetzung für $appName angefordert. Dein Code lautet:

$verificationCode

Gib diesen Code in der App ein. Der Code ist 15 Minuten gültig.

Falls du keine Zurücksetzung angefordert hast, kannst du diese E-Mail ignorieren.

– Dein $appName Team''',
  };

  String renderHtml({
    required String appName,
    required String verificationCode,
  }) => switch (this) {
    EmailTemplate.registrationVerification =>
      '''
<!DOCTYPE html>
<html lang="de">
<body>
  <p>Hallo,</p>
  <p>danke, dass du dich bei $appName registriert hast. Dein Bestätigungscode lautet:</p>
  <p style="font-size:24px;font-weight:bold;">$verificationCode</p>
  <p>Gib diesen Code in der App ein, um deine E-Mail-Adresse zu bestätigen. Der Code ist 15&nbsp;Minuten gültig.</p>
  <p>Falls du dich nicht registriert hast, kannst du diese E-Mail ignorieren.</p>
  <p>– Dein $appName Team</p>
</body>
</html>''',
    EmailTemplate.passwordResetVerification =>
      '''
<!DOCTYPE html>
<html lang="de">
<body>
  <p>Hallo,</p>
  <p>du hast eine Passwort-Zurücksetzung für $appName angefordert. Dein Code lautet:</p>
  <p style="font-size:24px;font-weight:bold;">$verificationCode</p>
  <p>Gib diesen Code in der App ein. Der Code ist 15&nbsp;Minuten gültig.</p>
  <p>Falls du keine Zurücksetzung angefordert hast, kannst du diese E-Mail ignorieren.</p>
  <p>– Dein $appName Team</p>
</body>
</html>''',
  };
}
