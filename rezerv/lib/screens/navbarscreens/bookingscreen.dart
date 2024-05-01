import 'package:flutter/material.dart';
import 'package:rezerv/components/bookingcard.dart';
import 'package:rezerv/const/styles.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Your Bookings',
              style: mainTextStyle,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookingCard(
                    hotelName: 'Hotel ABC',
                    location: 'City XYZ',
                    numberOfNights: 3,
                    numberOfRooms: 2,
                    checkInDate: DateTime.now(),
                    checkOutDate: DateTime.now().add(Duration(days: 3)),
                    totalAmount: 500.0,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
