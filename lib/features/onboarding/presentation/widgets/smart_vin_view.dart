import 'package:auto_hub_app/core/constants/app_images.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Onboarding page 3: Smart VIN Lookup.
class SmartVinView extends StatelessWidget {
  const SmartVinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 48.h),
          // VIN card section
          Center(
            child: SizedBox(
              width: 242.w,
              child: Image.asset(
                AppImages.onboardingPage3,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          // Text content
          Row(
            children: [
              Container(
                width: 24.w,
                height: 1.h,
                color: AppColors.onboardingCyan.withValues(alpha: 0.4),
              ),
              SizedBox(width: 8.w),
              Text(
                'KEY FEATURE',
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
            'Smart VIN Lookup',
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
            'Enter your 17-digit VIN number and instantly find exact-fit compatible parts for your specific vehicle.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 24.h),
          _buildFeatureBullet(Icons.qr_code_scanner, '17-digit VIN validation'),
          SizedBox(height: 12.h),
          _buildFeatureBullet(Icons.fact_check, 'Instant compatibility check'),
          SizedBox(height: 12.h),
          _buildFeatureBullet(Icons.verified, 'Exact-fit results only'),
        ],
      ),
    );
  }

  Widget _buildFeatureBullet(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: AppColors.onboardingCyan.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.r),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 14.w,
            color: AppColors.onboardingCyan,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.onboardingTextSecondary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
