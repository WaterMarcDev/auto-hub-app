import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/request_junk/models/junk_models.dart';
import 'package:auto_hub_app/features/request_junk/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card displaying individual junk request information.
class RequestItemCard extends StatelessWidget {
  /// Creates a [RequestItemCard].
  const RequestItemCard({
    required this.request,
    required this.onTap,
    super.key,
  });

  /// The request details to display.
  final JunkRequest request;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          request.id,
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.onboardingTextPrimary,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Flexible(
                          child: StatusBadge(status: request.status),
                        ),
                      ],
                    ),
                  ),
                  if (request.offerAmount != null) ...[
                    SizedBox(width: 8.w),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          r'$',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.onboardingGreen,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '\$${request.offerAmount}',
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.onboardingGreen,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.directions_car_filled_outlined,
                    color: AppColors.onboardingTextSecondary,
                    size: 16.r,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      request.vehicleTitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onboardingTextSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    request.date,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onboardingTextSecondary.withValues(
                        alpha: 0.6,
                      ),
                      fontSize: 12.sp,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.onboardingTextSecondary.withValues(
                      alpha: 0.6,
                    ),
                    size: 18.r,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
