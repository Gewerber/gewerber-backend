// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/business/application/create_business_use_case.dart'
    as _i1059;
import '../../modules/business/application/get_business_use_case.dart' as _i910;
import '../../modules/business/application/list_my_businesses_use_case.dart'
    as _i28;
import '../../modules/business/application/update_business_use_case.dart'
    as _i748;
import '../../modules/business/data/serverpod_business_gateway.dart' as _i8;
import '../../modules/business/data/serverpod_membership_gateway.dart' as _i257;
import '../../modules/business/data/serverpod_tenant_resolver.dart' as _i707;
import '../../modules/business/domain/business_gateway.dart' as _i647;
import '../../modules/business/domain/membership_gateway.dart' as _i688;
import '../audit/audit_service.dart' as _i473;
import '../events/event_bus.dart' as _i557;
import '../events/message_central_event_bus.dart' as _i991;
import '../tenant/tenant_resolver.dart' as _i343;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i473.AuditService>(() => _i473.AuditService());
    gh.singleton<_i647.BusinessGateway>(() => _i8.ServerpodBusinessGateway());
    gh.singleton<_i688.MembershipGateway>(
      () => _i257.ServerpodMembershipGateway(),
    );
    gh.singleton<_i557.EventBus>(() => _i991.MessageCentralEventBus());
    gh.singleton<_i1059.CreateBusinessUseCase>(
      () => _i1059.CreateBusinessUseCase(
        gh<_i647.BusinessGateway>(),
        gh<_i688.MembershipGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i343.TenantResolver>(
      () => _i707.ServerpodTenantResolver(gh<_i688.MembershipGateway>()),
    );
    gh.singleton<_i28.ListMyBusinessesUseCase>(
      () => _i28.ListMyBusinessesUseCase(
        gh<_i647.BusinessGateway>(),
        gh<_i688.MembershipGateway>(),
      ),
    );
    gh.singleton<_i748.UpdateBusinessUseCase>(
      () => _i748.UpdateBusinessUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i647.BusinessGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i910.GetBusinessUseCase>(
      () => _i910.GetBusinessUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i647.BusinessGateway>(),
      ),
    );
    return this;
  }
}
