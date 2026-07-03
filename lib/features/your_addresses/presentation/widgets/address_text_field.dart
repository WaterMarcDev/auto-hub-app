import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const AddressTextField({
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.onboardingTextSecondary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          validator: validator,
          onChanged: onChanged,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onboardingTextPrimary,
            fontSize: 14.sp,
          ),
          cursorColor: AppColors.onboardingCyan,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: AppColors.onboardingSurfaceLight,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.colorWhite.withValues(alpha: 0.08),
                width: 0.8,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.colorWhite.withValues(alpha: 0.08),
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.onboardingCyan,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 0.8,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.0,
              ),
            ),
            errorStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.error,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}
