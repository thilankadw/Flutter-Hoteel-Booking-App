import 'package:rezerv/screens/authenticate/login.dart';
import 'package:rezerv/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool loginPage = true;

  //toggle pages
  void switchPages() {
    setState(() {
      loginPage = !loginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginPage == true) {
      return Login(toggle: switchPages);
    } else {
      return Register(toggle: switchPages);
    }
  }
}
