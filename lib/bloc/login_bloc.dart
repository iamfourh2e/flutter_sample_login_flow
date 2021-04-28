import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import '../provider.dart';

class LoginBLoC {
  var subjectValidate = BehaviorSubject<bool>();
  var subjectIsLoading = BehaviorSubject<bool>();

  dispose() {
    subjectValidate.close();
    subjectIsLoading.close();
  }

  Future handleLogin(username, password) {
    var url  = Uri.parse('$BaseURL/user/login');
    return http.post(url, body: {
      "username": username,
      "password": password
    }).then((http.Response response) {
      subjectIsLoading.add(false);
      return jsonDecode(response.body);
    }).catchError((err) {
      subjectIsLoading.add(false);

      return err;
    });
  }
}
