import 'package:flutter/material.dart';
import 'package:mobilellc_task/screens/musiclist/booklist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: themeColorBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookCards(),
    );
  }
}