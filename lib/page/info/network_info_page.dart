import 'package:flutter/material.dart';
import 'package:get_device_information/api/network_info_api.dart';
import 'package:get_device_information/widget/info_widget.dart';

class NetworkInfoPage extends StatefulWidget {
  const NetworkInfoPage({Key? key}) : super(key: key);

  @override
  NetworkInfoPageState createState() => NetworkInfoPageState();
}

class NetworkInfoPageState extends State<NetworkInfoPage> {
  Map<String, dynamic> networkInfo = {};

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final networkInfo = await NetworkInfoApi.getNetworkInfo();


    if (!mounted) return;

    setState(() => this.networkInfo = networkInfo);
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(infoMap: networkInfo);
  }
}
