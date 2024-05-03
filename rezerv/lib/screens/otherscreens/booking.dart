import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _numberOfPersons = 1;
  int _numberOfRooms = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          style: const ButtonStyle(
            iconSize: MaterialStatePropertyAll(25.0),
            iconColor: MaterialStatePropertyAll(white),
            backgroundColor: MaterialStatePropertyAll(mainBlue),
          ),
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
                Text(
                  'Hotel Name',
                  style: secondaryTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Price per night: \$100', // Replace with actual price
                  style: regularTextStyle,
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Adjust the padding value as needed
                  child: Container(
                    height: 55.0,
                    width: double
                        .infinity, // Makes the button take up the full width
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            mainBlue), // Example button color
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Adjust the border radius as needed
                          ),
                        ),
                        // Remove fixedSize property to allow full width
                      ),
                      onPressed: () {
                        // Implement booking functionality
                      },
                      child: Text(
                        'Add Booking',
                        style: btnTextStyle.copyWith(
                            color:
                                white), // Make sure to define your btnTextStyle
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
}
