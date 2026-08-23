import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/create_customer_use_case.dart';
import '../application/get_customer_use_case.dart';
import '../application/list_customers_cursor_page_use_case.dart';
import '../application/list_customers_page_use_case.dart';
import '../application/list_customers_use_case.dart';
import '../application/update_customer_use_case.dart';

class CustomerEndpoint extends BusinessScopedEndpoint {
  Future<Customer> create(
    Session session,
    CreateCustomerRequest request, {
    int? businessId,
  }) {
    return getIt<CreateCustomerUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<Customer> get(Session session, int customerId, {int? businessId}) {
    return getIt<GetCustomerUseCase>().call(
      session,
      customerId,
      businessId: businessId,
    );
  }

  Future<Customer> update(
    Session session,
    UpdateCustomerRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateCustomerUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<List<Customer>> list(
    Session session, {
    CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListCustomersUseCase>().call(
      session,
      status: status,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }

  /// Paged variant of [list] that additionally returns the total number of
  /// matching rows. The page size cap is applied as in [list].
  Future<CustomerListPage> listPage(
    Session session, {
    CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListCustomersPageUseCase>().call(
      session,
      status: status,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }

  /// Keyset-paginated variant of [list] for very large lists. Stable order:
  /// `createdAt DESC, id DESC`. Pass the previous page's
  /// [CustomerCursorPage.nextCursor] back as `cursor` (`null` = first page);
  /// a `null` result cursor marks the end. Cursors are tenant-scoped: one
  /// minted for another business is rejected with a [ValidationException]
  /// (field `cursor`), just like a malformed or tampered cursor. The page
  /// size cap is applied as in [list]; no total count is computed.
  Future<CustomerCursorPage> listCursorPage(
    Session session, {
    CustomerStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) {
    return getIt<ListCustomersCursorPageUseCase>().call(
      session,
      status: status,
      limit: limit,
      cursor: cursor,
      businessId: businessId,
    );
  }
}
