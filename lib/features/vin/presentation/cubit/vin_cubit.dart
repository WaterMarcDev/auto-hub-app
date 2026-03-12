import 'package:auto_hub_app/features/vin/domain/usecases/decode_vin_usecase.dart';
import 'package:auto_hub_app/features/vin/presentation/cubit/vin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VinCubit extends Cubit<VinState> {
  VinCubit(this._decodeVin) : super(const VinInitial());

  final DecodeVinUsecase _decodeVin;

  Future<void> lookupVin(String vin) async {
    emit(const VinLoading());
    final result = await _decodeVin(vin);
    result.fold(
      (failure) => emit(VinError(failure.message)),
      (data) => emit(VinLoaded(data)),
    );
  }

  void reset() => emit(const VinInitial());
}
