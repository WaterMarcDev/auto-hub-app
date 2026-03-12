import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';

/// Data model for the NHTSA vehicle decoding API response.
///
/// Endpoint: GET https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvalues/{VIN}?format=json
/// The API returns a `Results` array with exactly one object containing
/// all decoded fields.
class VinDecodeModel extends VinDecodeResult {
  const VinDecodeModel({
    required super.vin,
    required super.year,
    required super.make,
    required super.model,
    super.trim,
    super.series,
    super.bodyClass,
    super.doors,
    super.driveType,
    super.engineHp,
    super.engineCylinders,
    super.displacementL,
    super.fuelType,
    super.transmissionStyle,
    super.manufacturerName,
    super.plantCountry,
  });

  factory VinDecodeModel.fromJson(Map<String, dynamic> json) {
    // Helper to extract a trimmed string field, defaulting to ''
    String f(String key) => (json[key] as String? ?? '').trim();

    // Format displacement: "1.5" → "1.5L"
    final rawDisp = f('DisplacementL');
    final disp = rawDisp.isNotEmpty ? '$rawDisp L' : '';

    return VinDecodeModel(
      vin: f('VIN'),
      year: f('ModelYear'),
      make: _titleCase(f('Make')),
      model: _titleCase(f('Model')),
      trim: f('Trim'),
      series: f('Series'),
      bodyClass: f('BodyClass'),
      doors: f('Doors'),
      driveType: f('DriveType'),
      engineHp: f('EngineHP'),
      engineCylinders: f('EngineCylinders'),
      displacementL: disp,
      fuelType: f('FuelTypePrimary'),
      transmissionStyle: f('TransmissionStyle'),
      manufacturerName: _titleCase(f('ManufacturerName')),
      plantCountry: _titleCase(f('PlantCountry')),
    );
  }

  static String _titleCase(String s) {
    if (s.isEmpty) return s;
    return s
        .split(' ')
        .map(
          (w) => w.isEmpty
              ? w
              : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
