import 'package:rxdart/rxdart.dart';

class AppBloc {
  String token;

  var subjectToken = BehaviorSubject<String>(); //publisher,អ្នកផ្សព្វផ្សាយ

  dispose() {
    subjectToken.close();
  }
}
