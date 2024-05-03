// Import required packages and files
import 'package:flutter/material.dart';
import 'package:rezerv/components/hotelcard.dart';
import 'package:rezerv/screens/otherscreens/filter.dart';
import 'package:rezerv/screens/otherscreens/hoteldetails.dart'; // Import your HotelDetailsPage file
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> hotels = [
    {
      'imageUrl': 'assets/images/hotelimage.png',
      'rating': 4.5,
      'hotelName':
          'Example Hotel Example Hotel Example Hotel Example Hotel Example Hotel Example Hotel',
      'price': 120.0,
    },
    {
      'imageUrl': 'assets/images/hotelimage.png',
      'rating': 4.5,
      'hotelName':
          'Example Hotel Example Hotel Example Hotel Example Hotel Example Hotel Example Hotel',
      'price': 120.0,
    },
    {
      'imageUrl': 'assets/images/hotelimage.png',
      'rating': 4.5,
      'hotelName':
          'Example Hotel Example Hotel Example Hotel Example Hotel Example Hotel Example Hotel',
      'price': 120.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Your existing UI code...
                  const SizedBox(height: 10),
                  const Text(
                    'Location',
                    style: descriptionStyle,
                  ),
                  Text(
                    "Colombo",
                    style: mainTextStyle.copyWith(fontSize: 24.0),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.blue,
                      ),
                      height: 120,
                      width: double.infinity,
                      child: SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Hotels",
                    style: mainTextStyle,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 320,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hotels.length,
                      itemBuilder: (BuildContext context, int index) {
                        final hotel = hotels[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to HotelDetailsPage when a hotel card is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelDetailsPage(
                                    // imageUrl: hotel['imageUrl'],
                                    // rating: hotel['rating'],
                                    // hotelName: hotel['hotelName'],
                                    // price: hotel['price'],
                                    ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: HotelCard(
                              imageUrl: hotel['imageUrl'],
                              rating: hotel['rating'],
                              hotelName: hotel['hotelName'],
                              price: hotel['price'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainBlue),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilterHotelsPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.filter_alt,
                            color: white,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Filter Hotels",
                            style: btnTextStyle.copyWith(color: white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
