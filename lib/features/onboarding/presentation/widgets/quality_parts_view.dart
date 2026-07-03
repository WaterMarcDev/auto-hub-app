import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/constants/app_images.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QualityPartsView extends StatelessWidget {
  const QualityPartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 48.h),
          // Floating Graphic Section
          Center(
            child: SizedBox(
              height: 250.h,
              child: Image.asset(
                AppImages.onboardingPage2,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 24.h),

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
                'WHAT WE DO',
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
            'Quality Used Parts, Fast',
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
            'Browse thousands of OEM-grade auto parts from verified '
            'salvage yards across the United States.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 24.h),

          // Bullet points
          _buildFeatureBullet(
            AppIcons.category,
            '18,000+ parts across 8 categories',
          ),
          SizedBox(height: 12.h),
          _buildFeatureBullet(AppIcons.verified, 'Every yard verified & rated'),
          SizedBox(height: 12.h),
          _buildFeatureBullet(AppIcons.security, 'Warranty on every listing'),
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
