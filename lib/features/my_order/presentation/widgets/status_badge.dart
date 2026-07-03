import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/my_order/domain/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, super.key});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color bgColor;
    String label;

    switch (status) {
      case OrderStatus.delivered:
        textColor = AppColors.onboardingGreen;
        bgColor = AppColors.onboardingGreen.withValues(alpha: 0.1);
        label = 'Delivered';
      case OrderStatus.inTransit:
        textColor = AppColors.onboardingCyan;
        bgColor = AppColors.onboardingCyan.withValues(alpha: 0.1);
        label = 'In Transit';
      case OrderStatus.processing:
        textColor = AppColors.warning;
        bgColor = AppColors.warning.withValues(alpha: 0.1);
        label = 'Processing';
      case OrderStatus.cancelled:
        textColor = AppColors.error;
        bgColor = AppColors.error.withValues(alpha: 0.1);
        label = 'Cancelled';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: textColor.withValues(alpha: 0.15),
          width: 0.8,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: textColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
