import 'package:get_it/get_it.dart';

import '../data/repositories/repositories.dart';

class RepositoryDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory(() => DatabaseHelper());
    injector.registerFactory<IAppRepository>(() => AppRepository(injector()));
  }
}