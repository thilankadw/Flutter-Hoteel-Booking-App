import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rezerv/const/styles.dart';

class VehicleBookingCard extends StatelessWidget {
  final String vehicleId;
  final DateTime startDate;
  final DateTime endDate;

  VehicleBookingCard({
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
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
                vehicleId,
                style: secondaryTextStyle,
              ),
              const SizedBox(height: 5),
              Text(
                'Start Date: ${DateFormat('dd MMM yyyy').format(startDate)}',
                style: regularTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                'End Date: ${DateFormat('dd MMM yyyy').format(endDate)}',
                style: regularTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
