import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rezerv/const/styles.dart';

class BookingCard extends StatelessWidget {
  final String hotelName;
  final String location;
  final int numberOfNights;
  final int numberOfRooms;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  BookingCard({
    required this.hotelName,
    required this.location,
    required this.numberOfNights,
    required this.numberOfRooms,
    required this.checkInDate,
    required this.checkOutDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotelName,
                style: secondaryTextStyle,
              ),
              const SizedBox(height: 5),
              Text(
                location,
                style: descriptionStyle,
              ),
              SizedBox(height: 16),
              Text(
                'Number of Nights: $numberOfNights',
                style: regularTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                'Number of Rooms: $numberOfRooms',
                style: regularTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                'Check-In Date: ${DateFormat('dd MMM yyyy').format(checkInDate)}',
                style: regularTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                'Check-Out Date: ${DateFormat('dd MMM yyyy').format(checkOutDate)}',
                style: regularTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
