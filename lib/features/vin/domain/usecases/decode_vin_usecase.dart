import 'package:auto_hub_app/core/errors/failures.dart';
import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';
import 'package:auto_hub_app/features/vin/domain/repositories/vin_repository.dart';
import 'package:fpdart/fpdart.dart';

class DecodeVinUsecase {
  const DecodeVinUsecase(this._repository);

  final VinRepository _repository;

  Future<Either<Failure, VinDecodeResult>> call(String vin) {
    return _repository.decodeVin(vin.toUpperCase().trim());
  }
}
