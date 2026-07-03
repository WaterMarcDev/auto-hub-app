import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget displayed when the requests list is empty.
class EmptyRequestsState extends StatelessWidget {
  /// Creates an [EmptyRequestsState].
  const EmptyRequestsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppIcons.history,
            color: AppColors.onboardingTextSecondary.withValues(alpha: 0.3),
            size: 64.r,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Requests Found',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Requests in this category will appear here.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
