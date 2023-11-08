import 'package:get_it/get_it.dart';

import '../data/services/services.dart';

class ServiceDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory<ISplashService>(() => SplashService(injector()));
    injector.registerFactory<IHomeService>(() => HomeService(injector()));
    injector
        .registerFactory<IItemInfoService>(() => ItemInfoService(injector()));
    // injector.registerFactory<IScannerService>(() => ScannerService(injector()));
  }
}
