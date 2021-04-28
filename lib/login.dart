import 'package:another_flushbar/flushbar.dart';
import 'package:eis_owner/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:eis_owner/bloc/app_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';
import 'bloc/app_state.dart';
import 'model/user.dart';

class Login extends StatefulWidget {
  final AppBloc appBloc;

  const Login({Key key, this.appBloc}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  Box box;
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  AnimationController animationController;

  Animation animation;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBLoC loginBLoC = LoginBLoC();

  initBox() async {
    box = await Hive.openBox('app');
  }

  @override
  void initState() {
    super.initState();
    initBox();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut)
          ..addListener(() {
            setState(() {});
          });
    animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: animation,
        child: Form(
          key: _formState,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            loginBLoC.subjectValidate.add(_formState.currentState.validate());
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            children: [
              40.heightBox,
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/logo.png'))),
              ),
              10.heightBox,
              "Welcome EIS Board".text.size(20).bold.make().objectCenter(),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return "Username is required";
                  }
                  return null;
                },
                controller: usernameController,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Password"),
              ),
              StreamBuilder(
                initialData: false,
                stream: loginBLoC.subjectValidate,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return TextButton(
                      onPressed: snapshot.data
                          ? () {
                              loginBLoC.subjectIsLoading.add(true);
                              loginBLoC
                                  .handleLogin(usernameController.text.trim(),
                                      passwordController.text.trim())
                                  .then((res) {
                                if (res['code'] == 201) {
                                  User user = User.fromJson(res['data']);
                                  if (!user.roles.contains('owner')) {
                                    Flushbar(
                                      title: "Message",
                                      message:
                                          "Sorry you not allow to use this app",
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                      flushbarPosition: FlushbarPosition.TOP,
                                    )..show(context);
                                  } else {
                                    box.put('username',
                                        usernameController.text.trim());
                                    box.put('password',
                                        passwordController.text.trim());
                                    context
                                        .read<AppState>()
                                        .setToken(res['token']);
                                    context.read<AppState>().setUser(user);
                                    widget.appBloc.subjectUser.add(user);
                                  }
                                } else {
                                  Flushbar(
                                    title: "Message",
                                    message: "${res['data']}",
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    flushbarPosition: FlushbarPosition.TOP,
                                  )..show(context);
                                }
                              }).catchError((err) {
                                Flushbar(
                                  title: "Message",
                                  duration: Duration(seconds: 2),
                                  message: "${err.toString()}",
                                  backgroundColor: Colors.red,
                                )..show(context);
                              });
                            }
                          : null,
                      child: "Login Now".text.make());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
