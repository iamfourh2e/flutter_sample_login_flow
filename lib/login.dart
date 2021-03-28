import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/bloc/app_bloc.dart';

class Login extends StatefulWidget {
  final AppBloc appBloc;

  const Login({Key key, this.appBloc}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Box box;

  initBox() async {
    box = await Hive.openBox('app');
  }

  @override
  void initState() {
    super.initState();
    initBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        child: Text("Login"),
        onPressed: () {
          widget.appBloc.subjectToken.add("123123123");
          box.put('token', "123123123");
        },
      ),
      body: Center(
        child: Text("Kak login"),
      ),
    );
  }
}
