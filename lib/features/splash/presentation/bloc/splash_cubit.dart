import 'package:auto_hub_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Cubit responsible for initialization and determining the 
/// initial routing destination (Home, Onboarding, or Login).
@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initial());

  /// Initializes the app and checks authentication status.
  /// 
  /// According to requirements (PRD-F01):
  /// - Displays splash for ≤2s
  /// - Navigates based on auth state and first-time user status.
  Future<void> initializeApp() async {
    // Artificial delay to satisfy the 1.5 - 2.0s splash requirement
    // while we wait for actual initialization logic (like DB, Firebase, etc).
    await Future<void>.delayed(const Duration(seconds: 2));
    
    // TODO(splash): Implement real auth checking and shared_prefs for first
    // time. For now, default to unauthenticated and first-time to show 
    // onboarding.
    // emit(const SplashState.authenticated());
    emit(const SplashState.unauthenticated(isFirstTime: true));
  }
}
