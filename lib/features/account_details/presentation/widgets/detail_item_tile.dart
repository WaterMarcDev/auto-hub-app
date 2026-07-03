import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailItemTile extends StatelessWidget {
  const DetailItemTile({
    required this.label,
    this.value,
    this.iconPath,
    this.iconColor,
    this.iconBackgroundColor,
    this.labelColor,
    this.valueColor,
    this.showDivider = true,
    this.onTap,
    super.key,
  });

  final String label;
  final String? value;
  final IconData? iconPath;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? labelColor;
  final Color? valueColor;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 0.8,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          // Left Icon (if present)
          if (iconPath != null) ...[
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? const Color(0x1F0DA0CE),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                iconPath!,
                color: iconColor ?? AppColors.onboardingTextPrimary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 14.w),
          ],

          // Label
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color:
                    labelColor ??
                    (iconPath != null
                        ? AppColors.onboardingTextPrimary
                        : AppColors.onboardingTextSecondary),
                fontSize: 14.sp,
                fontWeight: iconPath != null
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
          ),

          // Right Value (if present)
          if (value != null)
            Text(
              value!,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMedium.copyWith(
                color: valueColor ?? AppColors.onboardingTextPrimary,
                fontSize: value!.contains('\n') ? 12.sp : 14.sp,
                fontWeight: value!.contains('\n')
                    ? FontWeight.w500
                    : FontWeight.w600,
                height: 1.2,
              ),
            ),
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: content,
        ),
      );
    }

    return content;
  }
}
