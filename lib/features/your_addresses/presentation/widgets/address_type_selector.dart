import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeSelected;

  const AddressTypeSelector({
    required this.selectedType,
    required this.onTypeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TYPE',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.onboardingTextSecondary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildTypeButton(
              type: 'home',
              label: 'Home',
              icon: Icons.home_outlined,
            ),
            SizedBox(width: 10.w),
            _buildTypeButton(
              type: 'work',
              label: 'Work',
              icon: Icons.work_outline_rounded,
            ),
            SizedBox(width: 10.w),
            _buildTypeButton(
              type: 'other',
              label: 'Other',
              icon: Icons.apartment_rounded,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeButton({
    required String type,
    required String label,
    required IconData icon,
  }) {
    final isSelected = selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeSelected(type),
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.onboardingCyan.withValues(alpha: 0.05)
                : AppColors.onboardingSurfaceLight,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.onboardingCyan
                  : Colors.white.withValues(alpha: 0.08),
              width: isSelected ? 1.2 : 0.8,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isSelected
                    ? AppColors.onboardingCyan
                    : AppColors.onboardingTextSecondary,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected
                      ? AppColors.onboardingCyan
                      : AppColors.onboardingTextSecondary,
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
