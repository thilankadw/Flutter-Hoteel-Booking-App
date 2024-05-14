import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rezerv/models/BookingModel.dart';
import 'package:rezerv/models/VehicleBooking.dart';

class VehicleBookingServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createVehicleBooking({
    required String userId,
    required String vehicleId,
    required DateTime startDate,
    required DateTime endDate,
    required String model,
    required double price,
    required String vehicleNo,
  }) async {
    try {
      DocumentReference bookingRef =
          await _firestore.collection('vehiclebookings').add({
        'userId': userId,
        'vehicleId': vehicleId,
        'startDate': startDate,
        'endDate': endDate,
        'model': model,
        'price': price,
        'vehicleNo': vehicleNo,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return bookingRef.id;
    } catch (e) {
      print("Error creating booking: $e");
      throw e;
    }
  }

  Future<List<VehicleBooking>> getAllVehicleBookingsForUser(
      String userId) async {
    List<VehicleBooking> vehiclebookings = [];

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('vehiclebookings')
          .where('userId', isEqualTo: userId)
          .get();

      querySnapshot.docs.forEach((doc) {
        vehiclebookings.add(VehicleBooking(
          id: doc.id,
          userId: doc['userId'],
          vehicleId: doc['vehicleId'],
          startDate: (doc['startDate'] as Timestamp).toDate(),
          endDate: (doc['endDate'] as Timestamp).toDate(),
          model: doc['model'],
          price: doc['price'],
          vehicleNo: doc['model'],
        ));
      });

      return vehiclebookings;
    } catch (e) {
      print("Error getting bookings for user: $e");
      return [];
    }
  }
}
