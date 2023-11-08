import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_route_observer.dart';

final AppRouteObserver routeObserver = AppRouteObserver();

class Routes {
  static String get splash => "/";
  static String get home => "home";
  static String get itemInfo => "itemInfo";
  static String get qrCodeSharing => "qrCodeSharing";
  static String get bioPreview => "bioPreview";
  static String get scanner => "scanner";
  static String get setting => "settings";

  static MaterialPageRoute getRoutes(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(
          title: const Text("Not found"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Page Not Found"),
        ),
      );
    }
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }
}
