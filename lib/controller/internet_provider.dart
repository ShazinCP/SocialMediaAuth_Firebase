import 'dart:io';
import 'package:flutter/material.dart';

class InternetProvider extends ChangeNotifier {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  InternetProvider() {
    checkInternetConnection();
  }

  String internet = "";

  Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _hasInternet = true;
        internet = "Turn off the data and repress again";
        notifyListeners();
      }
    } on SocketException catch (_) {
      _hasInternet = false;
      internet = "Turn On the data and repress again";
      notifyListeners();
    }
  }
}
