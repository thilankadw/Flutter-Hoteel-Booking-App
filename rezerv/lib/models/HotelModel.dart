import 'dart:ffi';

class HotelModel {
  final String id;
  final String name;
  final String description;
  final double rating;
  final String imageUrl;
  final double pricePerNight;
  final String location;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.pricePerNight,
    required this.location,
  });

  factory HotelModel.fromFirestore(Map<String, dynamic> data, String id) {
    return HotelModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      rating: data['rating'],
      imageUrl: data['imageUrl'] ?? '',
      pricePerNight: data['pricePerNight'],
      location: data['location'],
    );
  }
}
