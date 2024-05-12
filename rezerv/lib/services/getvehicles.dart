import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rezerv/models/VehicleModel.dart';

class VehicleServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VehicleModel>> getAllVehicles() async {
    List<VehicleModel> vehicles = [];

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('vehicles').get();

      querySnapshot.docs.forEach((doc) {
        vehicles.add(VehicleModel(
          id: doc.id,
          vehicleNo: doc['vehicleNo'],
          model: doc['model'],
          type: doc['type'],
          price: doc['price']?.toDouble() ?? 0.0,
          imageUrl: doc['imageUrl'],
          availability: doc['availability'] ?? false,
        ));
      });

      return vehicles;
    } catch (e) {
      print("Error getting all vehicles: $e");
      return [];
    }
  }

  Future<VehicleModel?> getVehicleById(String id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('vehicles').doc(id).get();

      if (docSnapshot.exists) {
        return VehicleModel(
          id: docSnapshot.id,
          vehicleNo: docSnapshot['vehicleNo'],
          model: docSnapshot['model'],
          type: docSnapshot['type'],
          price: docSnapshot['price']?.toDouble() ?? 0.0,
          imageUrl: docSnapshot['imageUrl'],
          availability: docSnapshot['availability'] ?? false,
        );
      } else {
        print("Vehicle with ID $id not found.");
        return null;
      }
    } catch (e) {
      print("Error getting vehicle by ID: $e");
      return null;
    }
  }
}
