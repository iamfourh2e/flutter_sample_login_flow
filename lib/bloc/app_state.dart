import 'package:eis_owner/model/user.dart';
import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier {
  var token = '';
  User user;

  setToken(val) {
    token = val;
    notifyListeners();
  }

  setUser(val) {
    user = val;
    notifyListeners();
  }
}
