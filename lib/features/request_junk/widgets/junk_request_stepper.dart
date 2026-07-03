import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Top header stepper for New Junk Request.
class JunkRequestStepper extends StatelessWidget {
  /// Creates a [JunkRequestStepper] widget.
  const JunkRequestStepper({
    required this.currentStep,
    required this.totalSteps,
    required this.onBack,
    super.key,
  });

  /// The active step (1-indexed).
  final int currentStep;

  /// The total number of steps in the form flow.
  final int totalSteps;

  /// Callback when the back button is tapped.
  final VoidCallback onBack;

  String get _subtitle {
    switch (currentStep) {
      case 1:
        return 'Tell us about your vehicle';
      case 2:
        return 'Vehicle condition & details';
      case 3:
        return 'Pickup location & notes';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.colorWhite.withValues(alpha: 0.08),
                ),
              ),
              child: const Icon(
                AppIcons.chevronLeft,
                color: AppColors.colorWhite,
                size: 24,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Junk Request ($currentStep/$totalSteps)',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  _subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onboardingTextSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
