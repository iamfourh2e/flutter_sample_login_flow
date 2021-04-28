import 'package:eis_owner/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:eis_owner/bloc/app_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/app_state.dart';
import 'model/user.dart';

class LoadingResource extends StatefulWidget {
  final AppBloc appBloc;

  const LoadingResource({Key key, this.appBloc}) : super(key: key);
  @override
  _LoadingResourceState createState() => _LoadingResourceState();
}

class _LoadingResourceState extends State<LoadingResource> {
  LoginBLoC loginBLoC = LoginBLoC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading"),
      ),
    );
  }
  handleLogin (username,password,box) {
    loginBLoC.subjectIsLoading.add(true);
    loginBLoC
        .handleLogin(username,
        password)
        .then((res) {
      if (res['code'] == 201) {
        User user = User.fromJson(res['data']);
        if (user.roles.contains('owner')) {
          context.read<AppState>().setToken(res['token']);
          context.read<AppState>().setUser(user);
          widget.appBloc.subjectUser.add(user);
        }else{
          widget.appBloc.subjectUser.add(null);

        }
      } else {
        widget.appBloc.subjectUser.add(null);

      }
    });
  }
  @override
  void initState() {
    super.initState();
    //check resource
    Future.delayed(Duration(milliseconds: 2000), () {
      //add or publish an event
      // Hive.deleteBoxFromDisk('app');
      Hive.openBox('app')
          .then((box)  {
            String username = box.get('username');
            String password = box.get('password');
            if(username.isNotEmpty) {
              handleLogin(username, password,box);

            }else{
              widget.appBloc.subjectUser.add(null);

            }

      });
    });
  }
}
