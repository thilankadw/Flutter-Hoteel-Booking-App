import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rezerv/const/styles.dart';

class VehicleBookingCard extends StatelessWidget {
  final String vehicleId;
  final DateTime startDate;
  final DateTime endDate;
  final String vehicleNo;
  final String model;
  final double price;

  VehicleBookingCard({
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.model,
    required this.price,
    required this.vehicleNo,
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
                vehicleNo,
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
              SizedBox(height: 10),
              Text(
                'Model: ${model}',
                style: regularTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                'Price: \$${price}',
                style: regularTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
