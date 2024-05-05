import 'package:rezerv/const/colors.dart';
import 'package:rezerv/screens/navbarscreens/bookingscreen.dart';
import 'package:rezerv/screens/navbarscreens/homescree.dart';
import 'package:rezerv/screens/navbarscreens/profile.dart';
import 'package:rezerv/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();

  int _currentIndex = 0;
  List<Widget> body = const [
    HomeScreen(),
    BookingScreen(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          fontFamily: 'PoppinsRegular',
          fontSize: 15,
        ),
        selectedIconTheme: const IconThemeData(
          size: 35,
        ),
        selectedItemColor: mainBlue,
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'PoppinsRegular',
          fontSize: 15,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 25,
        ),
        unselectedItemColor: bgBlack,
        currentIndex: _currentIndex,
        onTap: (int nextIndex) {
          // Corrected syntax here
          setState(() {
            _currentIndex = nextIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Bookings',
            icon: Icon(
              Icons.book_online,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
