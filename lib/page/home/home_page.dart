import 'package:get_device_information/page/info/application_info_page.dart';
import 'package:get_device_information/page/info/device_info_page.dart';
import 'package:get_device_information/page/info/network_info_page.dart';
import '../../api/platform_identifier_api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('${PlatformIdentifierApi.device}\'s Info'),
          backgroundColor: const Color(0xFF008069),
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFFb3d9d2),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('USAMA MUZAFFAR',),
                accountEmail: Text('Flutter Developer',),
                decoration: BoxDecoration(
                  color: Color(0xFF008069)
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/usama.jpg',),
                ),
              ),
              ListTile(
                selectedColor: const Color(0xFF008069),
                selected: index == 1,
                leading: const Icon(Icons.device_unknown_rounded),
                title: const Text('Device Info'),
                onTap: () {
                  Navigator.pop(context);
                  if (index != 1) {
                    setState(() => index = 1);
                  }
                },
              ),
              ListTile(
                selectedColor: const Color(0xFF008069),
                selected: index == 2,
                leading: const Icon(Icons.contact_support_outlined),
                title: const Text('Application Info'),
                onTap: () {
                  Navigator.pop(context);
                  if (index != 2) {
                    setState(() => index = 2);
                  }
                },
              ),
              ListTile(
                selectedColor: const Color(0xFF008069),
                selected: index == 3,
                leading: const Icon(Icons.network_check_rounded),
                title: const Text('Network Info'),
                onTap: () {
                  Navigator.pop(context);
                  if (index != 3) {
                    setState(() => index = 3);
                  }
                },
              ),
            ],
          ),
        ),
        body: index == 1
            ? const DeviceInfoPage()
            : index == 2
                ? const ApplicationInfoPage()
                : index == 3
                    ? const NetworkInfoPage()
                    : const Center(
                        child: Text(
                            'ERROR!',
                            textAlign: TextAlign.center)));
  }
}
