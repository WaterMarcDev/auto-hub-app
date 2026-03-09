import 'dart:async';

import 'package:auto_hub_app/core/constants/app_images.dart';
import 'package:auto_hub_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:auto_hub_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:auto_hub_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _innerRingScale;
  late Animation<double> _outerRingScale;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    // Fade in rings gradually
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    // Inner ring: scales from logo size (112) to 165
    _innerRingScale = Tween<double>(begin: 112, end: 165).animate(curve);

    // Outer ring: same scale range but staggered (starts at 10%) for depth
    _outerRingScale = Tween<double>(begin: 112, end: 225).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Start the animation slightly after the page loads
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildCenterLogo() {
    return Container(
      width: 112.w,
      height: 112.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF0DA0CE),
          width: 4.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0DA0CE).withValues(alpha: 0.5),
            blurRadius: 48.r,
            offset: Offset(0, 8.h),
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
        padding: EdgeInsets.all(2.w),
        child: ClipOval(
          child: Image.asset(
            AppImages.splashLogo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer animated ring (staggered)
                        Opacity(
                          opacity: _fadeAnimation.value,
                          child: Container(
                            width: _outerRingScale.value.w,
                            height: _outerRingScale.value.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF0DA0CE)
                                    .withValues(alpha: 0.07),
                                width: 0.8.w,
                              ),
                            ),
                          ),
                        ),
                        // Inner animated ring
                        Opacity(
                          opacity: _fadeAnimation.value,
                          child: Container(
                            width: _innerRingScale.value.w,
                            height: _innerRingScale.value.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF0DA0CE)
                                    .withValues(alpha: 0.15),
                                width: 0.8.w,
                              ),
                            ),
                          ),
                        ),
                        // Central logo (passed as child so it is not rebuilt every frame)
                        child!,
                      ],
                    );
                  },
                  child: _buildCenterLogo(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
