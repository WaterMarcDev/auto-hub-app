import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/my_order/domain/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({required this.events, required this.status, super.key});

  final List<OrderTimelineEvent> events;
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    Color activeColor;
    switch (status) {
      case OrderStatus.delivered:
        activeColor = AppColors.onboardingGreen;
      case OrderStatus.inTransit:
        activeColor = AppColors.onboardingCyan;
      case OrderStatus.processing:
        activeColor = AppColors.warning;
      case OrderStatus.cancelled:
        activeColor = AppColors.error;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ORDER TIMELINE',
          style: GoogleFonts.inter(
            color: AppColors.onboardingTextSecondary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final event = events[index];
            final isLast = index == events.length - 1;
            final isCompleted = event.isCompleted;

            // Determine if the line connecting to the next event is active
            final isLineActive = !isLast && events[index].isCompleted;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 24.w,
                    child: Column(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? activeColor
                                : AppColors.onboardingInactive,
                            border: isCompleted
                                ? null
                                : Border.all(
                                    color: AppColors.onboardingTextSecondary
                                        .withValues(alpha: 0.3),
                                    width: 1.6,
                                  ),
                            boxShadow: isCompleted
                                ? [
                                    BoxShadow(
                                      color: activeColor.withValues(alpha: 0.4),
                                      blurRadius: 6.r,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2.w,
                              color: isLineActive
                                  ? activeColor
                                  : AppColors.onboardingInactive,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: isCompleted
                                  ? AppColors.onboardingTextPrimary
                                  : AppColors.onboardingTextSecondary,
                              fontSize: 14.sp,
                              fontWeight: isCompleted
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            event.time ?? 'Pending',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: event.time == 'Pending' || !isCompleted
                                  ? AppColors.onboardingTextMuted
                                  : AppColors.onboardingTextSecondary,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
