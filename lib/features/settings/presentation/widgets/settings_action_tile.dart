import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsActionTile extends StatelessWidget {
  const SettingsActionTile({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showDivider = true,
    this.titleColor,
    this.subtitleColor,
    super.key,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? leading;
  final Widget? trailing;
  final bool showDivider;
  final Color? titleColor;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            border: showDivider
                ? Border(
                    bottom: BorderSide(
                      color: AppColors.colorWhite.withValues(alpha: 0.05),
                      width: 0.8,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: 12.w),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: titleColor ?? AppColors.onboardingTextPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: subtitleColor ?? AppColors.onboardingTextSecondary,
                          fontSize: 11.5.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: 16.w),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
