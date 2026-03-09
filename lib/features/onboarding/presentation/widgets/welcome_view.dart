import 'package:auto_hub_app/core/constants/app_images.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.h),
          // Graphic section
          Center(
            child: SizedBox(
              height: 260.h,
              child: Image.asset(
                AppImages.onboardingPage1,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 48.h),
          // Text Content
          Row(
            children: [
              Container(
                width: 24.w,
                height: 1.h,
                color: AppColors.onboardingCyan.withValues(alpha: 0.4),
              ),
              SizedBox(width: 8.w),
              Text(
                'WELCOME TO',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onboardingCyan,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'AutoHub Express',
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 34.sp,
              height: 1.15,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "America's #1 junkyard & auto-parts marketplace — connecting "
            'buyers with verified salvage yards nationwide.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

}
