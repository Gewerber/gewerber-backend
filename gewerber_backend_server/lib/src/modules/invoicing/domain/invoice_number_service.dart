import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/sequence/domain/sequence_gateway.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_settings_gateway.dart';

/// Issues sequential, GoBD-friendly invoice numbers per business and year,
/// formatted according to the business settings (prefix, year, padding).
@singleton
class InvoiceNumberService {
  InvoiceNumberService(this._settings, this._sequences);

  final BusinessSettingsGateway _settings;
  final SequenceGateway _sequences;

  Future<String> nextInvoiceNumber(
    Session session, {
    required int businessId,
    required DateTime issueDate,
    Transaction? transaction,
  }) async {
    final settings =
        await _settings.findByBusinessId(session, businessId) ??
        BusinessSettings(businessId: businessId);

    final year = issueDate.year;
    final sequenceYear = settings.invoiceNumberIncludeYear ? year : 0;
    final counter = await _sequences.next(
      session,
      businessId: businessId,
      key: 'invoice',
      year: sequenceYear,
      transaction: transaction,
    );

    final counterPart = counter
        .toString()
        .padLeft(settings.invoiceNumberMinDigits, '0');
    final prefix = settings.invoiceNumberPrefix ?? '';
    return settings.invoiceNumberIncludeYear
        ? '$prefix$year-$counterPart'
        : '$prefix$counterPart';
  }
}
