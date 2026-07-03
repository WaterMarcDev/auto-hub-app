import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/my_order/domain/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({required this.order, required this.onTap, super.key});

  final Order order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusLabel;

    switch (order.status) {
      case OrderStatus.delivered:
        statusColor = AppColors.onboardingGreen;
        statusLabel = 'Delivered';
      case OrderStatus.inTransit:
        statusColor = AppColors.onboardingCyan;
        statusLabel = 'In Transit';
      case OrderStatus.processing:
        statusColor = AppColors.warning;
        statusLabel = 'Processing';
      case OrderStatus.cancelled:
        statusColor = AppColors.error;
        statusLabel = 'Cancelled';
    }

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final dateStr = '${months[order.date.month - 1]} '
        '${order.date.day}, ${order.date.year}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.onboardingSurfaceLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.inventory_2_outlined,
                size: 20.sp,
                color: statusColor,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.id,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.onboardingTextPrimary,
                        ),
                      ),
                      Text(
                        '\$${order.price.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.onboardingTextPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    order.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onboardingTextSecondary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        statusLabel,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: statusColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '·',
                        style: TextStyle(
                          color: AppColors.onboardingTextMuted,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        dateStr,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.onboardingTextMuted,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
