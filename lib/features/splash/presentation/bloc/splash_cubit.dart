import 'package:auto_hub_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Cubit responsible for initialization and determining the 
/// initial routing destination (Home, Onboarding, or Login).
@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initial());

  /// Initializes the application and determines the starting route.
  Future<void> initializeApp() async {
    // Artificial delay to satisfy splash visibility requirements.
    await Future<void>.delayed(const Duration(seconds: 2));
    
    // TODO(splash): Implement actual authentication and first-time user checks.
    // Defaulting to unauthenticated for initial development.
    emit(const SplashState.unauthenticated(isFirstTime: true));
  }
}
