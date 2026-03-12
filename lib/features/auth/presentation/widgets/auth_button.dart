import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {

  const AuthButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.isPrimary = true,
    this.enabled = true,
  });
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled;
    final bool showPrimary = isPrimary && isEnabled;

    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: showPrimary ? null : AppColors.onboardingSurfaceLight,
        gradient: showPrimary
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.onboardingCyan,
                  AppColors.onboardingCyanDark,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1.w,
        ),
        boxShadow: showPrimary
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
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.labelLarge.copyWith(
                color: showPrimary ? Colors.white : const Color(0xFF484F58),
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
