import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatelessWidget {

  const AuthTextField({
    required this.hintText,
    required this.prefixIcon,
    super.key,
    this.isPassword = false,
    this.suffixIconPath,
    this.suffixIconPathActive,
    this.controller,
    this.onChanged,
  });
  final String hintText;
  final Widget prefixIcon;
  final bool isPassword;
  final IconData? suffixIconPath;
  final IconData? suffixIconPathActive;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4.r,
            offset: Offset(0, 1.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: AppColors.onboardingCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14.r),
            ),
            padding: EdgeInsets.all(7.w),
            child: prefixIcon,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              onChanged: onChanged,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onboardingTextPrimary,
                fontSize: 14.sp,
              ),
              cursorColor: AppColors.onboardingCyan,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onboardingTextPrimary.withValues(alpha: 0.5),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
          if (isPassword && suffixIconPath != null)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: SizedBox(
                width: 16.w,
                height: 16.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(suffixIconPath!),
                    if (suffixIconPathActive != null)
                      Icon(suffixIconPathActive!),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
