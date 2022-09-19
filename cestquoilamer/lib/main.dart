import 'package:flutter/material.dart';
import 'package:cestquoilamer/screen/Login.dart';
import 'package:cestquoilamer/screen/HomePage.dart';
import 'package:cestquoilamer/screen/DashBoardPage.dart';
//import 'form_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Première application',
      //theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      //home: View_1(), // premiere vue
      // home: View_2(), // premiere vue
      // home: View_3(), // premiere vue
      home: DashBoardPage(),
    );
  }
}
