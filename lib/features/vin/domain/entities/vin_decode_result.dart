import 'package:equatable/equatable.dart';

class VinDecodeResult extends Equatable {
  const VinDecodeResult({
    required this.vin,
    required this.year,
    required this.make,
    required this.model,
    this.trim = '',
    this.series = '',
    this.bodyClass = '',
    this.doors = '',
    this.driveType = '',
    this.engineHp = '',
    this.engineCylinders = '',
    this.displacementL = '',
    this.fuelType = '',
    this.transmissionStyle = '',
    this.manufacturerName = '',
    this.plantCountry = '',
  });

  final String vin;
  final String year;
  final String make;
  final String model;
  final String trim;
  final String series;
  final String bodyClass;
  final String doors;
  final String driveType;
  final String engineHp;
  final String engineCylinders;
  final String displacementL;
  final String fuelType;
  final String transmissionStyle;
  final String manufacturerName;
  final String plantCountry;

  /// Full vehicle title, e.g. "2021 Honda Accord"
  String get vehicleTitle {
    return [year, make, model].where((s) => s.isNotEmpty).join(' ');
  }

  @override
  List<Object?> get props => [
    vin,
    year,
    make,
    model,
    trim,
    bodyClass,
    doors,
    driveType,
    engineHp,
    engineCylinders,
    displacementL,
    fuelType,
    transmissionStyle,
    manufacturerName,
    plantCountry,
  ];
}
