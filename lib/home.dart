import 'package:flutter/material.dart';
import 'package:eis_owner/bloc/app_bloc.dart';

import 'explore.dart';
import 'loading_resource.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppBloc appBloc;

  @override
  void initState() {
    appBloc = AppBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder( // subscriber
        initialData: null,
        stream: appBloc.subjectUser,
        builder: (context, AsyncSnapshot snapShot) {
          if(snapShot.connectionState == ConnectionState.waiting) {
            return LoadingResource(
              appBloc: appBloc
            );
          }
          if(snapShot.connectionState == ConnectionState.active) {
              if(snapShot.data == null) {
                return Login(
                  appBloc: appBloc,
                );
              }

              return Explore();
          }

          return Text("Problem with mother fker");
        },
      )
    );
  }
}
