import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flavor_config.dart';

enum AppEnvironment {
  prod,
  dev,
}

class FlavorHelper {
  static FlavorConfig appFlavor =
      kDebugMode ? FlavorConfig.dev() : FlavorConfig.prod();
  static AppEnvironment currentEnvironment = AppEnvironment.prod;

  /// get flavor name
  static String get name => appFlavor.name;

 static Future<void> initialize() async {
    String? flavor = await const MethodChannel('xyz.getin.scanner/channel')
        .invokeMethod<String>('getFlavor');

    debugPrint('STARTED WITH FLAVOR $flavor');
    currentEnvironment = flavor == 'prod'
        ? AppEnvironment.prod
        : AppEnvironment.dev;
  }

  /// get current [FlavorConfig] from Platform passed through method channel bridge

  static Future<FlavorConfig> getFlavorConfig() async {
    // String? flavor = await const MethodChannel('xyz.getin.scanner/channel')
    //     .invokeMethod<String>('getFlavor');
    //
    // debugPrint('STARTED WITH FLAVOR $flavor');
    // currentEnvironment = flavor == 'prod'
    //     ? AppEnvironment.prod
    //     : AppEnvironment.dev;

    if (devFlavor) {
      return FlavorConfig.dev();
    } else if (prodFlavor) {
      return FlavorConfig.prod();
    } else {
      throw Exception("Unknown flavor: $currentEnvironment");
    }
  }

  static bool get devFlavor  => currentEnvironment == AppEnvironment.dev;
  static bool get prodFlavor  => currentEnvironment == AppEnvironment.prod;

}
