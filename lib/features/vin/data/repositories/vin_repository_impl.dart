import 'package:auto_hub_app/core/errors/exceptions.dart';
import 'package:auto_hub_app/core/errors/failures.dart';
import 'package:auto_hub_app/features/vin/data/datasources/vin_remote_datasource.dart';
import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';
import 'package:auto_hub_app/features/vin/domain/repositories/vin_repository.dart';
import 'package:fpdart/fpdart.dart';

class VinRepositoryImpl implements VinRepository {
  const VinRepositoryImpl(this._datasource);

  final VinRemoteDatasource _datasource;

  @override
  Future<Either<Failure, VinDecodeResult>> decodeVin(String vin) async {
    try {
      final result = await _datasource.decodeVin(vin);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }
}
