import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rezerv/models/HotelModel.dart';

class HotelServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all hotels
  Future<List<HotelModel>> getAllHotels() async {
    List<HotelModel> hotels = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('hotels').get();

      querySnapshot.docs.forEach((doc) {
        hotels.add(HotelModel(
            id: doc.id,
            name: doc['name'],
            description: doc['description'],
            rating: (doc['rating'] ?? 0).toDouble(),
            imageUrl: doc['imageUrl'] ?? '',
            pricePerNight: (doc['pricePerNight'] ?? 0).toDouble(),
            location: doc['location']));
      });

      return hotels;
    } catch (e) {
      print("Error getting all hotels: $e");
      return [];
    }
  }

  Future<HotelModel?> getHotelById(String id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('hotels').doc(id).get();

      if (docSnapshot.exists) {
        return HotelModel(
            id: docSnapshot.id,
            name: docSnapshot['name'],
            description: docSnapshot['description'],
            rating: (docSnapshot['rating'] ?? 0).toDouble(),
            imageUrl: docSnapshot['imageUrl'] ?? '',
            pricePerNight: (docSnapshot['pricePerNight'] ?? 0).toDouble(),
            location: docSnapshot['location']);
      } else {
        print("Hotel with ID $id not found.");
        return null;
      }
    } catch (e) {
      print("Error getting hotel by ID: $e");
      return null;
    }
  }
}
