import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/onboarding_bottom_nav.dart';
import '../widgets/welcome_view.dart';
import '../widgets/quality_parts_view.dart';
import '../widgets/smart_vin_view.dart';
import '../widgets/wreck_to_cash_view.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final int _pageCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < _pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _onSkip() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    // Navigate away when onboarding is done
    // TODO: Update shared prefs / persistent storage in the future
    context.goNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SafeArea(
          child: Stack(
            children: [
              // Page View
              PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  WelcomeView(),
                  QualityPartsView(),
                  SmartVinView(),
                  WreckToCashView(),
                ],
              ),

              // Top Right Skip Button
              if (_currentIndex < _pageCount - 1)
                Positioned(
                  top: 12.h,
                  right: 24.w,
                  child: GestureDetector(
                    onTap: _onSkip,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

              // Bottom Navigation bar
              Positioned(
                bottom: 30.h, // Adjusted for typical safe area + spacing
                left: 24.w,
                right: 24.w,
                child: OnboardingBottomNav(
                  currentIndex: _currentIndex,
                  pageCount: _pageCount,
                  onNext: _onNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
