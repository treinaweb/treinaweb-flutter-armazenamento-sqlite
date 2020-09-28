import 'package:flutter/material.dart';
import 'package:lifepet_app/screens/login/login_screen.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pet Life",
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
