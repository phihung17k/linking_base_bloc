import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../pages/pages.dart';
import '../system/routes.dart';

class PageDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory<Widget>(() => const SplashPage(),
        instanceName: Routes.splash);
    injector.registerFactory<Widget>(() => const HomePage(),
        instanceName: Routes.home);
    injector.registerFactory<Widget>(() => const ItemInfoPage(),
        instanceName: Routes.itemInfo);
    // injector.registerFactory<Widget>(() => QRCodeSharingPage(injector()),
    //     instanceName: Routes.qrCodeSharing);
    // injector.registerFactory<Widget>(() => BioPreviewPage(injector()),
    //     instanceName: Routes.bioPreview);
    // injector.registerFactory<Widget>(() => ScannerPage(injector()),
    //     instanceName: Routes.scanner);
    // injector.registerFactory<Widget>(() => const SettingsPage(),
    //     instanceName: Routes.setting);
  }
}
