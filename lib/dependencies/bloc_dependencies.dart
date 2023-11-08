import 'package:get_it/get_it.dart';

import '../blocs/blocs.dart';

class BlocDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory(() => SplashBloc(injector()));
    injector.registerFactory(() => HomeBloc(injector()));
    injector.registerFactory(() => ItemInfoBloc(injector()));
    // injector.registerFactory(() => QRCodeBloc());
    // injector.registerFactory(() => BioPreviewBloc());
    // injector.registerFactory(() => ScannerBloc(injector()));
  }
}