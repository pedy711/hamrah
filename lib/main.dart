import 'package:flutter/material.dart';
import 'package:hamrah/ui/introductionPage.dart';
import './ui/homePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
//        home: new HomePage());
      home: new IntroductionPage());
  }
}
