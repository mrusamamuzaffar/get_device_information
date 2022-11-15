import 'package:flutter/material.dart';
import 'package:get_device_information/api/device_info_api.dart';
import 'package:get_device_information/api/ip_info_api.dart';
import 'package:get_device_information/api/package_info_api.dart';
import 'package:get_device_information/api/platform_identifier_api.dart';
import 'package:get_device_information/widget/info_widget.dart';

class ApplicationInfoPage extends StatefulWidget {
  const ApplicationInfoPage({Key? key}) : super(key: key);

  @override
  ApplicationInfoPageState createState() => ApplicationInfoPageState();
}

class ApplicationInfoPageState extends State<ApplicationInfoPage> {
  Map<String, dynamic> map = {};

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final packageName = await PackageInfoApi.getPackageName();
    final appVersion = await PackageInfoApi.getAppVersion();
    final ipAddress = await IpInfoApi.getIPAddress();
    final device = await DeviceInfoApi.getDeviceInfo();
    final deviceVersion = await DeviceInfoApi.getDeviceVersion();
    final operatingSystem = PlatformIdentifierApi.deviceType == DeviceType.isAndroid || PlatformIdentifierApi.deviceType == DeviceType.isIOS ? await DeviceInfoApi.getOperatingSystem() : 'Not supported';
    final screenResolution = await DeviceInfoApi.getScreenResolution();

    if (!mounted) return;

    setState(() => map = {
      'IP Address': ipAddress,
      'Device': device,
      'Operating system': operatingSystem,
      'OS version': deviceVersion,
      'Screen resolution': screenResolution,
      'App version': appVersion,
      PlatformIdentifierApi.deviceType == DeviceType.isAndroid ? 'Package name' : 'Bundle ID': packageName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(infoMap: map);
  }
}
