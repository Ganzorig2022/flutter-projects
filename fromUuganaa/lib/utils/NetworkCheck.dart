import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return checkStatus();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return checkStatus();
    }
    return checkStatus();
  }

  static Future<bool> checkStatus() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final lookupResult = await InternetAddress.lookup('www.google.mn');
      return lookupResult.isNotEmpty && lookupResult[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
