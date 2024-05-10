import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/screens/home/home.dart';
import 'package:rezerv/screens/navbarscreens/homescree.dart'; // Import your home screen

class CardDetailsScreen extends StatefulWidget {
  final String bookingId;

  const CardDetailsScreen({Key? key, required this.bookingId})
      : super(key: key);
  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Booking Confirmed',
            style: mainTextStyle,
          ),
          content: const Text(
            'Booking confirmed successfully',
            style: secondaryTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false,
                );
              },
              child: const Text(
                'OK',
                style: regularTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Card Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Card number field
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Expiry date field
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  if (!RegExp(r'^\d{2}\/\d{2}$').hasMatch(value)) {
                    return 'Please enter a valid expiry date (MM/YY)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // CVV field
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  if (!RegExp(r'^\d{3}$').hasMatch(value)) {
                    return 'Please enter a valid CVV (3 digits)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Submit button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 55.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showConfirmationDialog(context);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: btnTextStyle.copyWith(color: white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
}
