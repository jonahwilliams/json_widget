import 'package:flutter/material.dart';

import 'example.dart' as generated;
import 'foo.dart' as generated2;
import 'bar.dart' as generated3;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView(
          children: [
            generated.GeneratedWidget(),
            generated2.GeneratedWidget(),
            generated3.GeneratedWidget(),
          ]
        ),
      ),
    );
  }
}