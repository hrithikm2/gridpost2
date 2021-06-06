import 'package:GridPost2/UI/HomeScreen.dart';
import 'package:GridPost2/UI/grid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
