import 'dart:ffi';

import 'package:flutter/material.dart';

class VehicleModel {
  final String id;
  final String vehicleNo;
  final String model;
  final String type;
  final double price;
  final String imageUrl;
  final bool availability;

  VehicleModel({
    required this.id,
    required this.vehicleNo,
    required this.model,
    required this.type,
    required this.price,
    required this.imageUrl,
    required this.availability,
  });

  factory VehicleModel.fromFirestore(Map<String, dynamic> data, String id) {
    return VehicleModel(
      id: id,
      vehicleNo: data['vehicleNo'] ?? '',
      model: data['model'] ?? '',
      type: data['type'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      availability: data['availability'],
    );
  }
}
