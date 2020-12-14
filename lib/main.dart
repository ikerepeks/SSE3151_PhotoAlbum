import 'package:flutter/material.dart';
import 'package:photo_album/authenticate/singIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignIn());
  }
}
