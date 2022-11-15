import 'package:get_device_information/api/network_info_api.dart';
import 'package:get_device_information/api/platform_identifier_api.dart';
import 'home/home_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final PlatformIdentifierApi platformIdentifierApi = PlatformIdentifierApi();
  final NetworkInfoApi networkInfoApi = NetworkInfoApi();

  @override
  Widget build(BuildContext context) {
    networkInfoApi.enablePlatformOverrideForDesktop();
    platformIdentifierApi.getPlatformInit();
    return const HomePage();
  }
}
