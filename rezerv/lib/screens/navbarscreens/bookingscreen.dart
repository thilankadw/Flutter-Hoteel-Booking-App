import 'package:flutter/material.dart';
import 'package:rezerv/components/bookingcard.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/models/BookingModel.dart';
import 'package:rezerv/services/booking.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingServices _bookingServices = BookingServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<BookingCard> _bookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("====================");
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        print(user);
        List<BookingModel> userBookings =
            await _bookingServices.getAllBookingsForUser(user.uid);
        List<BookingCard> bookings = userBookings.map((booking) {
          return BookingCard(
            hotelName: booking.hotelName,
            location: booking.location,
            numberOfNights:
                booking.checkOutDate.difference(booking.checkInDate).inDays,
            numberOfRooms: booking.numberOfRooms,
            checkInDate: booking.checkInDate,
            checkOutDate: booking.checkOutDate,
          );
        }).toList();

        setState(() {
          _bookings = bookings;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Bookings',
          style: mainTextStyle,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _bookings.isEmpty
              ? const Center(
                  child: Text(
                    'No bookings found',
                    style: secondaryTextStyle,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _bookings
                          .map((booking) => BookingCard(
                                hotelName: booking.hotelName,
                                location: booking.location,
                                numberOfNights: booking.numberOfNights,
                                numberOfRooms: booking.numberOfRooms,
                                checkInDate: booking.checkInDate,
                                checkOutDate: booking.checkOutDate,
                              ))
                          .toList(),
                    ),
                  ),
                ),
    );
  }
}
