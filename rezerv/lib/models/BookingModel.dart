class BookingModel {
  final String id;
  final String userId;
  final String hotelId;
  final String hotelName;
  final String location;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfRooms;
  final int numberOfPersons;

  BookingModel({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.hotelName,
    required this.location,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfRooms,
    required this.numberOfPersons,
  });
}
