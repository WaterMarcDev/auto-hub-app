import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthToggleTab extends StatelessWidget {

  const AuthToggleTab({
    required this.isSignIn,
    required this.onSignInTap,
    required this.onSignUpTap,
    super.key,
  });
  final bool isSignIn;
  final VoidCallback onSignInTap;
  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.36,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(16.41),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 0.82,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4.1,
            offset: const Offset(0, 1.03),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 4.9,
        bottom: 0.82,
        left: 4.9,
        right: 4.9,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / 2;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: isSignIn ? 0 : tabWidth,
                width: tabWidth,
                height: 40.5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.onboardingCyan,
                        AppColors.onboardingCyanDark,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.36),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.onboardingCyan.withValues(alpha: 0.35),
                        blurRadius: 8.2,
                        offset: const Offset(0, 2.05),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onSignInTap,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 40.5,
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: AppTextStyles.labelLarge.copyWith(
                            color: isSignIn
                                ? Colors.white
                                : const Color(0xFF484F58),
                            fontSize: 13.33,
                            fontWeight: FontWeight.w700,
                          ),
                          child: const Text('Sign In'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onSignUpTap,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 40.5,
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: AppTextStyles.labelLarge.copyWith(
                            color: !isSignIn
                                ? Colors.white
                                : const Color(0xFF484F58),
                            fontSize: 13.33,
                            fontWeight: FontWeight.w700,
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
