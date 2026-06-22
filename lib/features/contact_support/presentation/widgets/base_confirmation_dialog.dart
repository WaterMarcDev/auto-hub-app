import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseConfirmationDialog extends StatelessWidget {
  const BaseConfirmationDialog({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.description,
    required this.confirmText,
    required this.confirmButtonColor,
    required this.onConfirm,
    this.iconBorderColor,
    this.confirmButtonShadowColor,
    this.cancelText = 'Cancel',
    this.onCancel,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Color? iconBorderColor;
  final String title;
  final String description;
  final String cancelText;
  final VoidCallback? onCancel;
  final String confirmText;
  final Color confirmButtonColor;
  final Color? confirmButtonShadowColor;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: AppColors.onboardingSurface,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 32.r,
              offset: Offset(0, 12.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Soft colored rounded container with icon
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16.r),
                border: iconBorderColor != null
                    ? Border.all(
                        color: iconBorderColor!,
                        width: 1.0,
                      )
                    : null,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: iconColor,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 20.h),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineSmall.copyWith(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            SizedBox(height: 12.h),
            // Subtitle / Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onboardingTextSecondary,
                fontSize: 13.5.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 28.h),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (onCancel != null) {
                        onCancel!();
                      }
                    },
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.onboardingBackground,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 0.8,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cancelText,
                        style: TextStyle(
                          color: AppColors.onboardingTextSecondary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: confirmButtonColor,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: confirmButtonShadowColor != null
                            ? [
                                BoxShadow(
                                  color: confirmButtonShadowColor!,
                                  blurRadius: 16.r,
                                  offset: Offset(0, 4.h),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
