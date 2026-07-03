import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Card showing salvage yard info.
class SalvageYardCard extends StatelessWidget {
  /// Creates a [SalvageYardCard].
  const SalvageYardCard({
    required this.name,
    required this.phone,
    super.key,
  });

  /// Name of the salvage yard.
  final String name;

  /// Contact phone of the salvage yard.
  final String phone;

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
              'SALVAGE YARD',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Row(
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: AppColors.onboardingCyan.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(

                    AppIcons.call,
                    color: AppColors.onboardingCyan,
                    size: 20,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onboardingTextPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        phone,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.onboardingTextSecondary.withValues(
                            alpha: 0.6,
                          ),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
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
