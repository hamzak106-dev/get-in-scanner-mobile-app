import '../flutter_flow/firebase_remote_config_util.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String apiBaseUrl;
  final bool shouldCollectCrashlytics;
  final bool enableLogging;
  final String powerSyncUrl;
  final String sbEmail;
  final String sbPassword;
  final String getInAppBaseUrl;
  final String imageBaseUrl;
  final String sbApiUrl;
  final String sbAnonKey;
  final String apiToken;
  final String scannerApiKey;
  final String apiVersion;

  FlavorConfig.dev()
      : name = "Dev",
        flavor = Flavor.dev,
        enableLogging = false,
        shouldCollectCrashlytics = false,
        apiBaseUrl = getRemoteConfigString("ScannerApiBaseUrl"),
        powerSyncUrl = getRemoteConfigString("powerSyncUrl"),
        sbEmail = getRemoteConfigString("sbEmail"),
        sbPassword = getRemoteConfigString("sbPassword"),
        getInAppBaseUrl = getRemoteConfigString("GetInBaseUrl"),
        imageBaseUrl = getRemoteConfigString("ImageBaseUrl"),
        sbApiUrl = getRemoteConfigString("sbApiUrl"),
        sbAnonKey = getRemoteConfigString("sbAnonKey"),
        apiToken = getRemoteConfigString("scannerApiToken"),
        scannerApiKey = getRemoteConfigString("scannerApiKey"),
        apiVersion = getRemoteConfigString('apiVersion');

  FlavorConfig.prod()
      : name = "Prod",
        flavor = Flavor.prod,
        enableLogging = true,
        shouldCollectCrashlytics = true,
        apiBaseUrl = getRemoteConfigString("ScannerApiBaseUrl"),
        powerSyncUrl = getRemoteConfigString("powerSyncUrl"),
        sbEmail = getRemoteConfigString("sbEmail"),
        sbPassword = getRemoteConfigString("sbPassword"),
        getInAppBaseUrl = getRemoteConfigString("GetInBaseUrl"),
        imageBaseUrl = getRemoteConfigString("ImageBaseUrl"),
        sbApiUrl = getRemoteConfigString("sbApiUrl"),
        sbAnonKey = getRemoteConfigString("sbAnonKey"),
        apiToken = getRemoteConfigString("scannerApiToken"),
        scannerApiKey = getRemoteConfigString("scannerApiKey"),
        apiVersion = getRemoteConfigString('apiVersion');
}
