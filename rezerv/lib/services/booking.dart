import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rezerv/models/BookingModel.dart';

class BookingServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createBooking({
    required String userId,
    required String hotelId,
    required String hotelName,
    required String location,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required int numberOfRooms,
    required int numberOfPersons,
  }) async {
    try {
      await _firestore.collection('bookings').add({
        'userId': userId,
        'hotelId': hotelId,
        'hotelName': hotelName,
        'location': location,
        'checkInDate': checkInDate,
        'checkOutDate': checkOutDate,
        'numberOfRooms': numberOfRooms,
        'numberOfPersons': numberOfPersons,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error creating booking: $e");
    }
  }

  // Get all bookings for a user
  Future<List<BookingModel>> getAllBookingsForUser(String userId) async {
    List<BookingModel> bookings = [];

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      querySnapshot.docs.forEach((doc) {
        bookings.add(BookingModel(
          id: doc.id,
          userId: doc['userId'],
          hotelId: doc['hotelId'],
          hotelName: doc['hotelName'],
          location: doc['location'],
          checkInDate: (doc['checkInDate'] as Timestamp).toDate(),
          checkOutDate: (doc['checkOutDate'] as Timestamp).toDate(),
          numberOfRooms: doc['numberOfRooms'],
          numberOfPersons: doc['numberOfPersons'],
        ));
      });

      return bookings;
    } catch (e) {
      print("Error getting bookings for user: $e");
      return [];
    }
  }
}
