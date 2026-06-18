import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onSetDefault;

  const AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
    this.onSetDefault,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHome = address.type == 'home';
    final bool isWork = address.type == 'work';

    IconData typeIcon;
    Color iconColor;
    Color iconBgColor;

    if (isHome) {
      typeIcon = Icons.home_outlined;
      iconColor = AppColors.onboardingCyan;
      iconBgColor = AppColors.onboardingCyan.withValues(alpha: 0.1);
    } else if (isWork) {
      typeIcon = Icons.work_outline_rounded;
      iconColor = AppColors.onboardingTextSecondary;
      iconBgColor = AppColors.onboardingSurfaceLight;
    } else {
      typeIcon = Icons.apartment_rounded;
      iconColor = AppColors.onboardingTextSecondary;
      iconBgColor = AppColors.onboardingSurfaceLight;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                width: 38.w,
                height: 38.h,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: isWork || address.type == 'other'
                      ? Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 0.8,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: Icon(
                  typeIcon,
                  color: iconColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 14.w),

              // Address Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          address.label,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.onboardingTextPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                          ),
                        ),
                        if (address.isDefault) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.onboardingGreen.withValues(
                                alpha: 0.08,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: AppColors.onboardingGreen.withValues(
                                  alpha: 0.2,
                                ),
                                width: 0.6,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 9.sp,
                                  color: AppColors.onboardingGreen,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  'DEFAULT',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.onboardingGreen,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '${address.streetAddress}\n${address.city}, ${address.state} ${address.zip}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onboardingTextSecondary,
                        fontSize: 13.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Set Default Button (if not default)
              if (!address.isDefault && onSetDefault != null)
                GestureDetector(
                  onTap: onSetDefault,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.onboardingGreen.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.onboardingGreen.withValues(alpha: 0.2),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 11.sp,
                          color: AppColors.onboardingGreen,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Set Default',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onboardingGreen,
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),

          // Action Buttons: Edit and Delete
          Padding(
            padding: EdgeInsets.only(left: 52.w),
            child: Row(
              children: [
                // Edit Button
                GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.onboardingCyan.withValues(alpha: 0.15),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 13.sp,
                          color: AppColors.onboardingCyan,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Edit',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onboardingCyan,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),

                // Delete Button
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.15),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          size: 13.sp,
                          color: AppColors.error,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Delete',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.error,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
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
