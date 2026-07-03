import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsSwitchTile extends StatelessWidget {
  const SettingsSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.showDivider = true,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onboardingTextSecondary,
                      fontSize: 11.5.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.onboardingCyan,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFF2E333D),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
