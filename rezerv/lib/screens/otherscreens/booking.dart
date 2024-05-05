import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/models/UserModel.dart';
import 'package:rezerv/services/auth.dart';
import 'package:rezerv/services/booking.dart'; // Import the BookingServices class

class BookingPage extends StatefulWidget {
  final String hotelId;
  final String priceperNight;
  final String hotelName;
  final String location;

  const BookingPage({
    required this.hotelId,
    required this.priceperNight,
    required this.hotelName,
    required this.location,
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _numberOfPersons = 1;
  int _numberOfRooms = 1;

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
          'Book Hotel',
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
                // Hotel Name and Price per night
                // Replace 'Hotel Name' and '\$100' with actual values
                Text(
                  'Hotel Name',
                  style: secondaryTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price per night: \$${widget.priceperNight}', // Replace with actual price
                  style: regularTextStyle,
                ),
                const SizedBox(height: 40),
                // Check-in Date
                const Text(
                  'Check-in Date',
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _selectCheckInDate(context);
                  },
                  child: Text(
                    _checkInDate != null
                        ? '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}'
                        : 'Select Check-in Date',
                    style: regularTextStyle,
                  ),
                ),
                SizedBox(height: 20),
                // Check-out Date
                const Text(
                  'Check-out Date',
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _selectCheckOutDate(context);
                  },
                  child: Text(
                    _checkOutDate != null
                        ? '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}'
                        : 'Select Check-out Date',
                    style: regularTextStyle,
                  ),
                ),
                SizedBox(height: 40),
                // Number of Persons Dropdown
                const Text(
                  'Number of Persons',
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 10),
                DropdownButton<int>(
                  value: _numberOfPersons,
                  onChanged: (newValue) {
                    setState(() {
                      _numberOfPersons = newValue!;
                    });
                  },
                  items: List.generate(10, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(
                        '${index + 1}',
                        style: regularTextStyle,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                // Number of Rooms Dropdown
                const Text(
                  'Number of Rooms',
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 10),
                DropdownButton<int>(
                  value: _numberOfRooms,
                  onChanged: (newValue) {
                    setState(() {
                      _numberOfRooms = newValue!;
                    });
                  },
                  items: List.generate(10, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(
                        '${index + 1}',
                        style: regularTextStyle,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 40),
                // Add Booking Button
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
    if (picked != null && picked != _checkInDate) {
      setState(() {
        _checkInDate = picked;
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate ?? DateTime.now(),
      firstDate: _checkInDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _checkOutDate) {
      if (picked.isAfter(_checkInDate!)) {
        setState(() {
          _checkOutDate = picked;
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

  void _addBooking() {
    BookingServices().createBooking(
      userId: _userId,
      hotelId: widget.hotelId,
      hotelName: widget.hotelName,
      location: widget.location,
      checkInDate: _checkInDate!,
      checkOutDate: _checkOutDate!,
      numberOfRooms: _numberOfRooms,
      numberOfPersons: _numberOfPersons,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Booking Successful',
            style: mainTextStyle.copyWith(fontSize: 25),
          ),
          content: const Text(
            'Your booking has been confirmed.',
            style: secondaryTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                'Go Home',
                style: regularTextStyle,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
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
