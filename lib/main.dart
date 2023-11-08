import 'package:flutter/material.dart';

import 'dependencies/app_dependencies.dart';
import 'system/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.setUp();
  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const Linking());
}

class Linking extends StatelessWidget {
  const Linking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Linking",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: (settings) => Routes.getRoutes(settings),
      navigatorObservers: [routeObserver],
    );
  }
}