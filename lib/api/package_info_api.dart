import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoApi {
  static Future<String> getPackageName() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.packageName;
  }

  static Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return '${packageInfo.version} + ${packageInfo.buildNumber}';
  }
}
