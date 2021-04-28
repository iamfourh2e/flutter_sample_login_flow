import 'package:eis_owner/model/user.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc {

  var subjectUser = BehaviorSubject<User>(); //publisher,អ្នកផ្សព្វផ្សាយ

  dispose() {
    subjectUser.close();
  }
}
