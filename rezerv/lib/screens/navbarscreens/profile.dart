import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              'Nissanka',
              style: mainTextStyle.copyWith(color: bgBlack),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            Text(
              'First Name: Pathum',
              style: btnTextStyle.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Last Name: Nissanka',
              style: btnTextStyle.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Email: pathumnish18@gmail.com',
              style: btnTextStyle.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 50.0),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainBlue),
                ),
                onPressed: () {},
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
