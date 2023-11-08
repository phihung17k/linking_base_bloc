import 'package:get_it/get_it.dart';

import 'bloc_dependencies.dart';
import 'page_dependencies.dart';
import 'repository_dependencies.dart';
import 'service_dependencies.dart';

class AppDependencies {
  static GetIt get _injector => GetIt.instance;

  static Future setUp() async {
    // _injector.registerLazySingleton(() => NetworkConnectivity());

    await RepositoryDependencies.setUp(_injector);
    await ServiceDependencies.setUp(_injector);
    await BlocDependencies.setUp(_injector);
    await PageDependencies.setUp(_injector);
  }
}