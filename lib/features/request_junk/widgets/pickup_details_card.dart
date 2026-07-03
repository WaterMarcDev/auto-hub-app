import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Card showing scheduled pickup details.
class PickupDetailsCard extends StatelessWidget {
  /// Creates a [PickupDetailsCard].
  const PickupDetailsCard({
    required this.pickupDateTime,
    required this.towCompany,
    super.key,
  });

  /// The scheduled date and time string.
  final String pickupDateTime;

  /// The assigned tow company name.
  final String towCompany;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.06),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
            child: Text(
              'PICKUP DETAILS',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          _buildPickupRow(
            
            icon: AppIcons.calendarToday,
            label: 'Date & Time',
            value: pickupDateTime,
          ),
          Divider(color: AppColors.colorWhite.withValues(alpha: 0.06), height: 1.h),
          _buildPickupRow(
            icon: AppIcons.localShipping,
            label: 'Tow Company',
            value: towCompany,
          ),
        ],
      ),
    );
  }

  Widget _buildPickupRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.onboardingCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: AppColors.onboardingCyan,
              size: 18.r,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onboardingTextSecondary.withValues(
                      alpha: 0.5,
                    ),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
