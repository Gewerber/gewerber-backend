import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/sequence/domain/sequence_gateway.dart';
import '../../../generated/protocol.dart';

/// Issues sequential, GoBD-friendly invoice numbers per business and year,
/// formatted according to the business settings (prefix, year, padding).
@singleton
class InvoiceNumberService {
  InvoiceNumberService(this._sequences);

  final SequenceGateway _sequences;

  Future<String> nextInvoiceNumber(
    Session session, {
    required int businessId,
    required DateTime issueDate,
    required BusinessSettings settings,
    Transaction? transaction,
  }) async {
    final year = issueDate.year;
    final sequenceYear = settings.invoiceNumberIncludeYear ? year : 0;
    final counter = await _sequences.next(
      session,
      businessId: businessId,
      key: 'invoice',
      year: sequenceYear,
      transaction: transaction,
    );

    final counterPart = counter.toString().padLeft(
      settings.invoiceNumberMinDigits,
      '0',
    );
    final prefix = settings.invoiceNumberPrefix ?? '';
    return settings.invoiceNumberIncludeYear
        ? '$prefix$year-$counterPart'
        : '$prefix$counterPart';
  }
}
