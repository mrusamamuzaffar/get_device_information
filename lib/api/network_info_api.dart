import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkInfoApi {
  void enablePlatformOverrideForDesktop() {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    }
  }

  static Future<Map<String, dynamic>> getNetworkInfo() async {
    String connectionStatus = 'Unknown';
    final NetworkInfo networkInfo = NetworkInfo();

    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubMask;

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await networkInfo.getWifiName();
        } else {
          wifiName = await networkInfo.getWifiName();
        }
      } else if (kIsWeb) {
        wifiName = 'Not Supported';
      } else {
        wifiName = await networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await networkInfo.getWifiBSSID();
        }
      } else if (kIsWeb) {
        wifiBSSID = 'Not Supported';
      } else {
        wifiBSSID = await networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      if (kIsWeb) {
        wifiIPv4 = 'Not Supported';
      } else {
        wifiIPv4 = await networkInfo.getWifiIP();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      if (kIsWeb) {
        wifiIPv6 = 'Not Supported';
      } else {
        wifiIPv6 = await networkInfo.getWifiIPv6();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      if (kIsWeb) {
        wifiSubMask = 'Not Supported';
      } else {
        wifiSubMask = await networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi sub mask address', error: e);
      wifiSubMask = 'Failed to get Wifi sub mask address';
    }

    try {
      if (kIsWeb) {
        wifiBroadcast = 'Not Supported';
      } else {
        wifiBroadcast = await networkInfo.getWifiBroadcast();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      if (kIsWeb) {
        wifiGatewayIP = 'Not Supported';
      } else {
        wifiGatewayIP = await networkInfo.getWifiGatewayIP();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    try {
      if (kIsWeb) {
        wifiSubMask = 'Not Supported';
      } else {
        wifiSubMask = await networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi sub mask', error: e);
      wifiSubMask = 'Failed to get Wifi sub mask';
    }

    return {
      'Connection status': connectionStatus,
      'Name': wifiName,
      'BSSID': wifiBSSID,
      'IPv4': wifiIPv4,
      'IPv6': wifiIPv6,
      'Gateway IP': wifiGatewayIP,
      'Broadcast': wifiBroadcast,
      'Sub mask': wifiSubMask,
    };
  }
}
