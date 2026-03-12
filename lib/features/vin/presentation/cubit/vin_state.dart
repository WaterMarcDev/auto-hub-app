import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';
import 'package:equatable/equatable.dart';

sealed class VinState extends Equatable {
  const VinState();

  @override
  List<Object?> get props => [];
}

final class VinInitial extends VinState {
  const VinInitial();
}

final class VinLoading extends VinState {
  const VinLoading();
}

final class VinLoaded extends VinState {
  const VinLoaded(this.result);

  final VinDecodeResult result;

  @override
  List<Object?> get props => [result];
}

final class VinError extends VinState {
  const VinError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
