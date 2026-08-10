import 'package:injectable/injectable.dart';

import 'injection.config.dart';
import 'service_locator.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
