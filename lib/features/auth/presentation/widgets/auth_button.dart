import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {

  const AuthButton({
    required this.text, required this.onPressed, super.key,
    this.isPrimary = true,
  });
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 57.5,
      decoration: BoxDecoration(
        color: isPrimary ? null : AppColors.onboardingSurfaceLight,
        gradient: isPrimary
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.onboardingCyan,
                  AppColors.onboardingCyanDark,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(16.41),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 0.82,
        ),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppColors.onboardingCyan.withValues(alpha: 0.35),
                  blurRadius: 8.2,
                  offset: const Offset(0, 2.05),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.41),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.labelLarge.copyWith(
                color: isPrimary ? Colors.white : const Color(0xFF484F58),
                fontSize: 15.38,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
