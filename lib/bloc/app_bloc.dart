import 'package:rxdart/rxdart.dart';

class AppBloc {

  var subjectToken = BehaviorSubject<String>(); //publisher,អ្នកផ្សព្វផ្សាយ

  dispose() {
    subjectToken.close();
  }
}
