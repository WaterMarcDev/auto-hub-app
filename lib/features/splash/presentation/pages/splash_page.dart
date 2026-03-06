import 'dart:async';

import 'package:auto_hub_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:auto_hub_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:auto_hub_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove the native splash background now that our Flutter UI is ready
    FlutterNativeSplash.remove();

    return BlocProvider(
      create: (context) {
        final cubit = getIt<SplashCubit>();
        unawaited(cubit.initializeApp());
        return cubit;
      },
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            authenticated: () {
              context.goNamed('home');
            },
            unauthenticated: (isFirstTime) {
              if (isFirstTime) {
                // Navigate to onboarding
                context.goNamed('onboarding');
              } else {
                // Navigate to login
                context.goNamed('login');
              }
            },
          );
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.08, 0.5, 0.91],
                colors: [
                  Color(0xFF080D14),
                  Color(0xFF0A1220),
                  Color(0xFF050810),
                ],
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glowing rings logic can be added here if needed
                  // using Container with BoxShape.circle and box shadows
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0DA0CE).withValues(alpha: 0.07),
                        width: 0.8,
                      ),
                    ),
                  ),
                  Container(
                    width: 165,
                    height: 165,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0DA0CE).withValues(alpha: 0.15),
                        width: 0.8,
                      ),
                    ),
                  ),
                  // The actual splash logo
                  Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0DA0CE),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0DA0CE)
                              .withValues(alpha: 0.5),
                          blurRadius: 48,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0DA0CE),
                          Color(0xFF0B8FB5),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/splash_logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
