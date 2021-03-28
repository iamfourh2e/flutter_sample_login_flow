import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  new Directory(appDocDirectory.path + '/' + 'dir')
      .create(recursive: true)
      .then((Directory directory) {
    Hive..init(directory.path);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
