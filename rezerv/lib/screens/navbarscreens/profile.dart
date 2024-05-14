import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/models/UserModel.dart';
import 'package:rezerv/screens/wrapper.dart';
import 'package:rezerv/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthServices _auth = AuthServices();

  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() async {
    UserModel? currentUser = await _auth.getCurrentUser();
    if (currentUser != null) {
      print(currentUser);
      setState(() {
        _user = currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Profile',
            style: mainTextStyle,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            const CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue,
              backgroundImage: AssetImage('assets/user_icon.png'),
              child: Icon(
                Icons.person,
                size: 50.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              _user.username,
              style: mainTextStyle.copyWith(color: bgBlack),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            Text(
              'First Name: ${_user.firstName}',
              style: btnTextStyle.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Last Name: ${_user.lastName}',
              style: btnTextStyle.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Email: ${_user.email}',
              style: btnTextStyle.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 50.0),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainBlue),
                ),
                onPressed: () async {
                  await _auth.LogOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Wrapper()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: white,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "Sign out",
                      style: btnTextStyle.copyWith(color: white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
