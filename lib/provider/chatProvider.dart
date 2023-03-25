import 'package:flutter/foundation.dart';

class Chatprovider extends ChangeNotifier {
  String? _email;
   String? _username;
    bool? _online;
      String _message="message";
      set setmessage(String message) {
    _message = message;
    notifyListeners();
  }
    String get getmessage=>_message!;
    set setonline(bool online) {
    _online = online;
    notifyListeners();
  }
   bool get getonline=>_online!;

  set setemail(String email) {
    _email = email;
    notifyListeners();
  }
  set setname(String name) {
    _username = name;
    notifyListeners();
  }
  String get getemail=>_email!;
  String get getname=>_username!;
}
