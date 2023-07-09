import 'package:flutter/material.dart';
import 'package:quizapp/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor:const Color.fromARGB(143, 35, 1, 51),
      ),
      home: const HomePage(),
    );
  }
}

