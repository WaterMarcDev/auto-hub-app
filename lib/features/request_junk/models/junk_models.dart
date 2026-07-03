import 'package:meta/meta.dart';
enum JunkRequestStatus {
  pickupScheduled('Pickup Scheduled'),
  offerPending('Offer Pending'),
  completed('Completed'),
  cancelled('Cancelled');
  final String label;
  const JunkRequestStatus(this.label);
}

/// Model representing a junk request.
@immutable
class JunkRequest {
  const JunkRequest({
    required this.id,
    required this.status,
    required this.vehicleTitle,
    required this.date,
    required this.vin,
    required this.condition,
    required this.notes,
    required this.salvageYardName,
    required this.salvageYardPhone,
    this.offerAmount,
    this.pickupDateTime,
    this.towCompany,
  });
  final String id;
  final JunkRequestStatus status;
  final String vehicleTitle;
  final String date;
  final String vin;
  final String condition;
  final String notes;
  final String salvageYardName;
  final String salvageYardPhone;
  final int? offerAmount;
  final String? pickupDateTime;
  final String? towCompany;
}
