import 'package:injectable/injectable.dart';

import '../../../generated/protocol.dart';

/// Versioned, in-code guidance content (tooltips, checklists, "What is
/// this?" popups). Content is curated centrally; user progress is stored in
/// the database.
@singleton
class GuidanceContentProvider {
  List<GuidanceTip> tips() {
    return [
      GuidanceTip(
        topic: 'invoicing.kleinunternehmer',
        title: 'Kleinunternehmerregelung (§ 19 UStG)',
        body:
            'Als Kleinunternehmer weist du keine Umsatzsteuer auf deinen '
            'Rechnungen aus und gibst keine Umsatzsteuer-Voranmeldungen ab. '
            'Voraussetzung: Dein Umsatz lag im Vorjahr unter 25.000 € und '
            'übersteigt im laufenden Jahr 100.000 € nicht. Auf der Rechnung '
            'muss ein Hinweis auf die Kleinunternehmerregelung stehen – '
            'Gewerber ergänzt ihn automatisch.',
      ),
      GuidanceTip(
        topic: 'invoicing.reverseCharge',
        title: 'Reverse Charge (Umkehr der Steuerschuld)',
        body:
            'Bei Leistungen an Unternehmen in anderen EU-Ländern mit gültiger '
            'USt-IdNr. geht die Umsatzsteuer auf den Leistungsempfänger über. '
            'Du stellst die Rechnung ohne Umsatzsteuer und weist auf den '
            'Übergang der Steuerschuld hin.',
      ),
      GuidanceTip(
        topic: 'invoicing.goBD',
        title: 'GoBD-konforme Rechnungsnummern',
        body:
            'Rechnungsnummern müssen eindeutig und fortlaufend sein '
            '(GoBD). Gewerber vergibt Nummern automatisch und lückenlos – '
            'so bleibt deine Buchführung prüfungssicher.',
      ),
      GuidanceTip(
        topic: 'accounting.euer',
        title: 'Einnahmenüberschussrechnung (EÜR)',
        body:
            'Als Einzelunternehmer oder Kleingewerbe ermittelst du deinen '
            'Gewinn in der Regel per EÜR: Einnahmen minus Ausgaben im '
            'Zufluss-/Abflussprinzip. Der Bericht in Gewerber zeigt dir '
            'jederzeit deinen aktuellen Stand.',
      ),
      GuidanceTip(
        topic: 'timeTracking.rounding',
        title: 'Zeiterfassung und Rundung',
        body:
            'Erfasse deine Arbeitszeiten direkt beim Kunden oder Projekt. '
            'In den Einstellungen kannst du Rundungsregeln festlegen '
            '(z. B. auf 15 Minuten), damit die Abrechnung einheitlich bleibt.',
      ),
      GuidanceTip(
        topic: 'business.legalForm',
        title: 'Rechtsform Einzelunternehmen',
        body:
            'Ein Einzelunternehmen entsteht ohne formale Gründung – mit der '
            'Anmeldung deines Gewerbes beim Gewerbeamt. Du haftest persönlich '
            'und versteuerst den Gewinn über deine Einkommensteuererklärung.',
      ),
    ];
  }

  List<ChecklistDefinition> checklists() {
    return [
      ChecklistDefinition(
        key: 'onboarding',
        title: 'Dein Start mit Gewerber',
        items: [
          ChecklistItemDefinition(
            key: 'onboarding/business-profile',
            title: 'Unternehmensprofil vervollständigen',
            body:
                'Hinterlege Name, Adresse und – falls vorhanden – '
                'USt-IdNr. oder Steuernummer. Diese Angaben erscheinen auf '
                'deinen Rechnungen.',
          ),
          ChecklistItemDefinition(
            key: 'onboarding/kleinunternehmer',
            title: 'Kleinunternehmerregelung prüfen',
            body:
                'Wenn dein Umsatz unter den Grenzen des § 19 UStG liegt, '
                'aktiviere die Kleinunternehmerregelung in den '
                'Unternehmenseinstellungen.',
          ),
          ChecklistItemDefinition(
            key: 'onboarding/first-customer',
            title: 'Ersten Kunden anlegen',
            body:
                'Lege deinen ersten Kunden mit Rechnungsadresse an – so '
                'kann die erste Rechnung direkt losgehen.',
          ),
          ChecklistItemDefinition(
            key: 'onboarding/first-invoice',
            title: 'Erste Rechnung erstellen',
            body:
                'Erstelle deine erste Rechnung. Gewerber übernimmt '
                'Nummerierung, Beträge und die korrekten Steuerhinweise.',
          ),
        ],
      ),
      ChecklistDefinition(
        key: 'first-invoice',
        title: 'Checkliste: Rechnung schreiben',
        items: [
          ChecklistItemDefinition(
            key: 'first-invoice/recipient',
            title: 'Rechnungsempfänger prüfen',
            body: 'Name und Anschrift des Kunden müssen vollständig sein.',
          ),
          ChecklistItemDefinition(
            key: 'first-invoice/items',
            title: 'Leistungen erfassen',
            body:
                'Beschreibe jede Leistung mit Menge, Einheit und Preis. Bei '
                'Zeitarbeit hilft dir die Übertragung aus der Zeiterfassung.',
          ),
          ChecklistItemDefinition(
            key: 'first-invoice/tax',
            title: 'Steuerhinweis kontrollieren',
            body:
                'Prüfe, ob Umsatzsteuer ausgewiesen wird oder ein Hinweis '
                '(Kleinunternehmer, Reverse Charge) nötig ist.',
          ),
          ChecklistItemDefinition(
            key: 'first-invoice/payment-terms',
            title: 'Zahlungsziel festlegen',
            body:
                'Ein klares Zahlungsziel (z. B. 14 Tage) hilft bei '
                'Zahlungserinnerungen und Mahnungen.',
          ),
        ],
      ),
    ];
  }
}
