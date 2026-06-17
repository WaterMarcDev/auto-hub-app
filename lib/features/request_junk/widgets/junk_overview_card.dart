import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/request_junk/models/junk.dart';
import 'package:auto_hub_app/features/request_junk/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Card showing the main overview details of a junk request.
class JunkOverviewCard extends StatelessWidget {
  /// Creates a [JunkOverviewCard].
  const JunkOverviewCard({
    required this.request,
    super.key,
  });

  /// The junk request details.
  final JunkRequest request;

  @override
  Widget build(BuildContext context) {
    final (cardColor, borderColor) = switch (request.status) {
      JunkRequestStatus.completed => (
          Color.lerp(
                AppColors.onboardingSurface,
                AppColors.onboardingGreen,
                0.02,
              ) ??
              AppColors.onboardingSurface,
          AppColors.onboardingGreen.withValues(alpha: 0.15),
        ),
      JunkRequestStatus.offerPending => (
          Color.lerp(AppColors.onboardingSurface, AppColors.warning, 0.02) ??
              AppColors.onboardingSurface,
          AppColors.warning.withValues(alpha: 0.15),
        ),
      JunkRequestStatus.pickupScheduled => (
          Color.lerp(
                AppColors.onboardingSurface,
                AppColors.onboardingCyan,
                0.02,
              ) ??
              AppColors.onboardingSurface,
          AppColors.onboardingCyan.withValues(alpha: 0.15),
        ),
      JunkRequestStatus.cancelled => (
          Color.lerp(AppColors.onboardingSurface, AppColors.error, 0.01) ??
              AppColors.onboardingSurface,
          AppColors.error.withValues(alpha: 0.1),
        ),
    };

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(status: request.status),
              if (request.offerAmount != null)
                Text(
                  '\$${request.offerAmount}',
                  style: AppTextStyles.displayLarge.copyWith(
                    color: AppColors.onboardingGreen,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            request.vehicleTitle,
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '${request.id} · VIN: ${request.vin}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
