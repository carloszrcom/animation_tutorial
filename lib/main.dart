import 'package:flutter/material.dart';

import 'basic_animation_page.dart';

void main() {
  runApp(MyApp());
}

/// Prueba de commit 2.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.blue[200],
      ),
      home: AnimationPage(),
    );
  }
}
