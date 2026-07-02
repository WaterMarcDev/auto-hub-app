import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/request_junk/models/junk_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable status badge for junk requests.
class StatusBadge extends StatelessWidget {
  /// Creates a [StatusBadge].
  const StatusBadge({
    required this.status,
    super.key,
  });

  /// The status of the request.
  final JunkRequestStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    Color bgColor;

    switch (status) {
      case JunkRequestStatus.pickupScheduled:
        color = AppColors.onboardingCyan;
        bgColor = AppColors.onboardingCyan.withValues(alpha: 0.1);
        break;
      case JunkRequestStatus.offerPending:
        color = AppColors.warning;
        bgColor = AppColors.warning.withValues(alpha: 0.1);
        break;
      case JunkRequestStatus.completed:
        color = AppColors.onboardingGreen;
        bgColor = AppColors.onboardingGreen.withValues(alpha: 0.1);
        break;
      case JunkRequestStatus.cancelled:
        color = AppColors.onboardingTextSecondary;
        bgColor = AppColors.onboardingTextSecondary.withValues(alpha: 0.1);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 0.8,
        ),
      ),
      child: Text(
        status.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
