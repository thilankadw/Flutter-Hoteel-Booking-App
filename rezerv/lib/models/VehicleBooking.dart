class VehicleBooking {
  final String id;
  final String userId;
  final String vehicleId;
  final DateTime startDate;
  final DateTime endDate;
  final String model;
  final double price;
  final String vehicleNo;

  VehicleBooking({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.model,
    required this.price,
    required this.vehicleNo,
  });
}
