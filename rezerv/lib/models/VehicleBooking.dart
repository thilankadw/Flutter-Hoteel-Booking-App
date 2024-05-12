class VehicleBooking {
  final String id;
  final String userId;
  final String vehicleId;
  final DateTime startDate;
  final DateTime endDate;

  VehicleBooking({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
  });
}
