import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'platform_identifier_api.dart';

class DeviceInfoApi {
  static final _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getOperatingSystem() async => Platform.operatingSystem;

  static Future<String> getScreenResolution() async =>
      '${window.physicalSize.width} X ${window.physicalSize.height}';

  static Future<String> getDeviceInfo() async {
    if (PlatformIdentifierApi.deviceType == DeviceType.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;

      return '${info.manufacturer} - ${info.model}';
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isIOS) {
      final info = await _deviceInfoPlugin.iosInfo;

      return '${info.name} ${info.model}';
    }  else if (PlatformIdentifierApi.deviceType == DeviceType.isWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;

      return '${info.browserName}';
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isWindows) {
      final info = await _deviceInfoPlugin.windowsInfo;

      return info.computerName;
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isMacOS) {
      final info = await _deviceInfoPlugin.macOsInfo;

      return '${info.computerName} - ${info.hostName}';
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isLinux) {
      final info = await _deviceInfoPlugin.linuxInfo;

      return '${info.name} - ${info.prettyName}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceVersion() async {
    if (PlatformIdentifierApi.deviceType == DeviceType.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;
      return info.version.sdkInt.toString();
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isIOS) {
      final info = await _deviceInfoPlugin.iosInfo;
      return info.systemVersion!;
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;
      return info.browserName.toString();
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isWindows) {
      final info = await _deviceInfoPlugin.windowsInfo;
      return '${info.numberOfCores} Cores';
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isMacOS) {
      final info = await _deviceInfoPlugin.macOsInfo;
      return info.kernelVersion;
    } else if (PlatformIdentifierApi.deviceType == DeviceType.isLinux) {
      final info = await _deviceInfoPlugin.linuxInfo;
      return info.version!;
    } else {
      throw UnimplementedError();
    }
  }

  static Future<Map<String, dynamic>> getInfo() async {
    try {
      if (PlatformIdentifierApi.deviceType == DeviceType.isAndroid) {
        final info = await _deviceInfoPlugin.androidInfo;
        return _readAndroidBuildData(info);
      } else if (PlatformIdentifierApi.deviceType == DeviceType.isIOS) {
        final info = await _deviceInfoPlugin.iosInfo;
        return _readIosDeviceInfo(info);
      } else if (PlatformIdentifierApi.deviceType == DeviceType.isWeb) {
        final info = await _deviceInfoPlugin.webBrowserInfo;
        return _readWebDeviceInfo(info);
      } else if (PlatformIdentifierApi.deviceType == DeviceType.isWindows) {
        final info = await _deviceInfoPlugin.windowsInfo;
        return _readWindowsDeviceInfo(info);
      } else if (PlatformIdentifierApi.deviceType == DeviceType.isMacOS) {
        final info = await _deviceInfoPlugin.macOsInfo;
        return _readMacOsDeviceInfo(info);
      } else if (PlatformIdentifierApi.deviceType == DeviceType.isLinux) {
        final info = await _deviceInfoPlugin.linuxInfo;
        return _readLinuxDeviceInfo(info);
      } else {
        throw UnimplementedError();
      }
    } on PlatformException {
      return <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo info) {
    return <String, dynamic>{
      'Device': info.device,
      'Brand': info.brand,
      'Physical device': info.isPhysicalDevice,
      'SDK version': info.version.sdkInt,
      'Manufacturer': info.manufacturer,
      'Model': info.model,
      'Security patch level': info.version.securityPatch,
      'Android version': info.version.release,
      'Preview SDK version': info.version.previewSdkInt,
      'Internal build value': info.version.incremental,
      'Code name': info.version.codename,
      'Base OS build': info.version.baseOS,
      'Board': info.board,
      'Bootloader': info.bootloader,
      'Build ID': info.display,
      'Fingerprint': info.fingerprint,
      'Hardware': info.hardware,
      'Host': info.host,
      'ID': info.id,
      'Product': info.product,
      '32 bit ABIs': info.supported32BitAbis,
      '64 bit ABIs': info.supported64BitAbis,
      'Supported ABIs': info.supportedAbis,
      'Tags': info.tags,
      'Build type': info.type,
      'System features': info.systemFeatures.join('\n\n'),
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    return <String, dynamic>{
      'Device name': info.name,
      'OS name': info.systemName,
      'OS version': info.systemVersion,
      'Device model': info.model,
      'Localized name': info.localizedModel,
      'Device identifier': info.identifierForVendor,
      'Physical device': info.isPhysicalDevice,
      'System name': info.utsname.sysname,
      'Network node': info.utsname.nodename,
      'Release level': info.utsname.release,
      'Version level': info.utsname.version,
      'Hardware type': info.utsname.machine,
    };
  }

  static Map<String, dynamic> _readWebDeviceInfo(WebBrowserInfo info) {
    return <String, dynamic>{
      'Browser name': info.browserName,
      'Device memory': '${info.deviceMemory} GB',
      'Logical processor': info.hardwareConcurrency,
      'Language': info.language,
      'Max touch points': info.maxTouchPoints,
      'Browser version': info.platform,
      'Product': info.product,
      'Build number:': info.productSub,
      'User agent:': info.userAgent,
      'Vendor:': info.vendor,
      'Vendor version:': info.vendorSub,
    };
  }

  static Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo info) {
    return <String, dynamic>{
      'Computer name': info.computerName,
      'CPU cores': info.numberOfCores,
      'System memory': '${info.systemMemoryInMegabytes} MB',
    };
  }

  static Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo info) {
    return <String, dynamic>{
      'Computer name': info.computerName,
      'Active CPUs': info.activeCPUs,
      'CPU architecture': info.arch,
      'CPU frequency': info.cpuFrequency,
      'OS name': info.hostName,
      'Kernel version': info.kernelVersion,
      'Memory': info.memorySize,
      'Device model': info.model,
      'OS release': info.osRelease,
      'Device GUID': info.systemGUID,
    };
  }

  static Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo info) {
    return <String, dynamic>{
      'Build ID': info.buildId,
      'ID': info.id,
      'ID like': info.idLike,
      'Machine ID': info.machineId,
      'OS name': info.name,
      'Pretty OS name': info.prettyName,
      'OS variant': info.variant,
      'Variant ID': info.variantId,
      'OS version': info.version,
      'Version code': info.versionCodename,
      'Version ID': info.versionId,
    };
  }
}
