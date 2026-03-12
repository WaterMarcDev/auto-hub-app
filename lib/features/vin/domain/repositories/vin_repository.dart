import 'package:auto_hub_app/core/errors/failures.dart';
import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class VinRepository {
  Future<Either<Failure, VinDecodeResult>> decodeVin(String vin);
}
