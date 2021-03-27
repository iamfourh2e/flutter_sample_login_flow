import 'package:flutter/material.dart';
import 'package:myapp/bloc/app_bloc.dart';

class LoadingResource extends StatefulWidget {
  final AppBloc appBloc;

  const LoadingResource({Key key, this.appBloc}) : super(key: key);
  @override
  _LoadingResourceState createState() => _LoadingResourceState();
}

class _LoadingResourceState extends State<LoadingResource> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //check resource
    Future.delayed(Duration(milliseconds: 2000), () {
      //add or publish an event
      widget.appBloc.subjectToken.add(null);
    });
  }
}
