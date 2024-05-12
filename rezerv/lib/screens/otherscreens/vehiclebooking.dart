import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/models/UserModel.dart';
import 'package:rezerv/screens/navbarscreens/homescree.dart';
import 'package:rezerv/screens/otherscreens/payment.dart';
import 'package:rezerv/services/auth.dart';
import 'package:rezerv/services/booking.dart';
import 'package:rezerv/services/vehicle.dart';

class VehicleBookingPage extends StatefulWidget {
  final String vehicleId;
  final double price;
  final String model;

  const VehicleBookingPage({
    required this.vehicleId,
    required this.price,
    required this.model,
  });

  @override
  _VehicleBookingPageState createState() => _VehicleBookingPageState();
}

class _VehicleBookingPageState extends State<VehicleBookingPage> {
  DateTime? _startDate;
  DateTime? _endDate;

  late String _userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    AuthServices _auth = AuthServices();
    UserModel? user = await _auth.getCurrentUser();
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Book Vehicle',
          style: mainTextStyle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${widget.model}',
                  style: secondaryTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(height: 40),
                // Check-in Date
                const Text(
                  'Start Date',
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _selectCheckInDate(context);
                  },
                  child: Text(
                    _startDate != null
                        ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                        : 'Select Check-in Date',
                    style: regularTextStyle,
                  ),
                ),
                SizedBox(height: 20),
                // Check-out Date
                const Text(
                  'End Date',
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _selectCheckOutDate(context);
                  },
                  child: Text(
                    _endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Select Check-out Date',
                    style: regularTextStyle,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addBooking,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Add Booking',
                        style: btnTextStyle.copyWith(color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      if (picked.isAfter(_startDate!)) {
        setState(() {
          _endDate = picked;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Date'),
              content: Text('Check-out date must come after check-in date.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _addBooking() async {
    if (_startDate == null || _endDate == null) {
      // If either check-in or check-out date is not selected, show a notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: mainBlue,
          content: Text(
            'Please select both start and end dates.',
            style: regularTextStyle.copyWith(color: white),
          ),
          duration:
              Duration(seconds: 2), // You can adjust the duration as needed
        ),
      );
      return; // Return without proceeding further
    }

    try {
      // Create the booking in Firebase and get the document ID
      String bookingId = await VehicleBookingServices().createVehicleBooking(
        userId: _userId,
        vehicleId: widget.vehicleId,
        startDate: _startDate!,
        endDate: _endDate!,
      );

      // Navigate to the card details screen, passing the booking ID
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during booking creation
      print('Error creating booking: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: mainTextStyle.copyWith(fontSize: 25),
            ),
            content: Text(
              'An error occurred while processing your booking. Please try again later.',
              style: secondaryTextStyle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok',
                  style: regularTextStyle,
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
