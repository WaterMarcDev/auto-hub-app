import 'package:auto_hub_app/core/errors/exceptions.dart';
import 'package:auto_hub_app/features/vin/data/models/vin_decode_model.dart';
import 'package:dio/dio.dart';

abstract interface class VinRemoteDatasource {
  Future<VinDecodeModel> decodeVin(String vin);
}

/// Calls the free NHTSA vPIC API — no API key required.
///
/// Docs: https://vpic.nhtsa.dot.gov/api/
class VinRemoteDatasourceImpl implements VinRemoteDatasource {
  VinRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  static const _baseUrl = 'https://vpic.nhtsa.dot.gov/api/vehicles';

  @override
  Future<VinDecodeModel> decodeVin(String vin) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseUrl/decodevinvalues/${vin.toUpperCase()}',
        queryParameters: {'format': 'json'},
      );

      final data = response.data;
      if (data == null) {
        throw const ServerException(
          message: 'Empty response received from the VIN lookup service.',
        );
      }

      final resultsList = data['Results'] as List?;
      if (resultsList == null || resultsList.isEmpty) {
        throw const ServerException(
          message: 'No results returned for this VIN.',
        );
      }

      final map = resultsList.first as Map<String, dynamic>;

      // Validate that at least the core vehicle fields were decoded.
      final make = (map['Make'] as String? ?? '').trim();
      final model = (map['Model'] as String? ?? '').trim();
      final year = (map['ModelYear'] as String? ?? '').trim();

      if (make.isEmpty && model.isEmpty && year.isEmpty) {
        throw const ServerException(
          message:
              'VIN not recognized. Please verify the VIN number and try again.',
        );
      }

      return VinDecodeModel.fromJson(map);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'Network error while looking up VIN.',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
