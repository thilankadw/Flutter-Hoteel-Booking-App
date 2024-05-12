import 'package:flutter/material.dart';
import 'package:rezerv/components/bookingcard.dart';
import 'package:rezerv/components/vehickebookingcard.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/models/BookingModel.dart';
import 'package:rezerv/models/VehicleBooking.dart';
import 'package:rezerv/services/booking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rezerv/services/vehicle.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final VehicleBookingServices _bookingServices = VehicleBookingServices();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<VehicleBookingCard> _bookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
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
        List<VehicleBooking> userBookings =
            await _bookingServices.getAllVehicleBookingsForUser(user.uid);
        List<VehicleBookingCard> bookings = userBookings.map((booking) {
          return VehicleBookingCard(
            vehicleId: booking.vehicleId, // Correct parameter name
            startDate: booking.startDate, // Correct parameter name
            endDate: booking.endDate,
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
                          .map((vehicle) => VehicleBookingCard(
                                vehicleId: vehicle.vehicleId,
                                startDate: vehicle.startDate,
                                endDate: vehicle.endDate,
                              ))
                          .toList(),
                    ),
                  ),
                ),
    );
  }
}
