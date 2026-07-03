import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Card showing vehicle details (condition, notes).
class VehicleInfoCard extends StatelessWidget {
  /// Creates a [VehicleInfoCard].
  const VehicleInfoCard({
    required this.condition,
    required this.notes,
    super.key,
  });

  /// The condition description.
  final String condition;

  /// The notes description.
  final String notes;

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
              'VEHICLE INFO',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          _buildInfoField('Condition', condition),
          Divider(color: AppColors.colorWhite.withValues(alpha: 0.06), height: 1.h),
          _buildInfoField('Notes', notes),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
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
    );
  }
}
