import 'package:auto_hub_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:auto_hub_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashCubit', () {
    late SplashCubit splashCubit;

    setUp(() {
      splashCubit = SplashCubit();
    });

    tearDown(() async {
      await splashCubit.close();
    });

    test('initial state should be SplashState.initial()', () {
      expect(splashCubit.state, const SplashState.initial());
    });

    blocTest<SplashCubit, SplashState>(
      'emits [SplashState.unauthenticated(isFirstTime: true)] '
      'when initializeApp is called',
      build: () => splashCubit,
      act: (cubit) => cubit.initializeApp(),
      wait: const Duration(seconds: 2), // wait for the artificial delay
      expect: () => const <SplashState>[
        SplashState.unauthenticated(isFirstTime: true),
      ],
    );
  });
}
