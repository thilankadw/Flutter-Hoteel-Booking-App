import 'package:rezerv/models/UserModel.dart';
import 'package:rezerv/screens/authenticate/authenticate.dart';
import 'package:rezerv/screens/authenticate/login.dart';
import 'package:rezerv/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //user data by provider
    final user = Provider.of<UserModel?>(context);

    // if (user == null) {
    //   return Authenticate();
    // } else {
    //   return Home();
    // }
    if (user == null) {
      return Home();
    } else {
      return Home();
    }
  }
}
