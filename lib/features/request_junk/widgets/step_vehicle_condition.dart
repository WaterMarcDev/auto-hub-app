import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 2: Vehicle condition & details.
class StepVehicleCondition extends StatelessWidget {
  /// Creates a [StepVehicleCondition] widget.
  const StepVehicleCondition({
    required this.selectedCondition,
    required this.onConditionChanged,
    required this.hasTitle,
    required this.onHasTitleChanged,
    required this.hasKeys,
    required this.onHasKeysChanged,
    super.key,
  });

  /// The currently selected condition string.
  final String selectedCondition;

  /// Callback when condition changes.
  final ValueChanged<String> onConditionChanged;

  /// Whether the user has the vehicle title.
  final bool hasTitle;

  /// Callback when the title status changes.
  final ValueChanged<bool> onHasTitleChanged;

  /// Whether the user has the vehicle keys.
  final bool hasKeys;

  /// Callback when the keys status changes.
  final ValueChanged<bool> onHasKeysChanged;

  /// Available vehicle conditions.
  static const List<String> conditions = [
    'Running – Good condition',
    'Running – Needs repairs',
    'Non-running – Fixable',
    'Non-running – Totaled/Scrap',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle condition & details',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 24.h),
          _buildLabel('CONDITION'),
          ...conditions.map(_buildConditionItem),
          SizedBox(height: 20.h),
          _buildLabel('DOCUMENTS'),
          Row(
            children: [
              Expanded(
                child: _buildDocumentToggle(
                  label: 'Has Title',
                  value: hasTitle,
                  onChanged: onHasTitleChanged,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildDocumentToggle(
                  label: 'Has Keys',
                  value: hasKeys,
                  onChanged: onHasKeysChanged,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildConditionItem(String condition) {
    final isSelected = selectedCondition == condition;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: () => onConditionChanged(condition),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.onboardingCyan.withValues(alpha: 0.05)
                : AppColors.onboardingSurface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.onboardingCyan
                  : AppColors.colorWhite.withValues(alpha: 0.08),
              width: isSelected ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Container(
                width: 22.r,
                height: 22.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.onboardingCyan
                        : AppColors.onboardingTextSecondary
                            .withValues(alpha: 0.4),
                    width: isSelected ? 6.r : 2.r,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  condition,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? AppColors.onboardingTextPrimary
                        : AppColors.onboardingTextPrimary
                            .withValues(alpha: 0.9),
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentToggle({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    const activeColor = AppColors.onboardingGreen;
    final inactiveColor =
        AppColors.onboardingTextSecondary.withValues(alpha: 0.4);

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: value
              ? activeColor.withValues(alpha: 0.05)
              : AppColors.onboardingSurface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: value ? activeColor : AppColors.colorWhite.withValues(alpha: 0.08),
            width: value ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              value ? AppIcons.checkCircleOutline : AppIcons.cancelOutlined,
              color: value ? activeColor : inactiveColor,
              size: 20.r,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: value
                    ? activeColor
                    : AppColors.onboardingTextPrimary.withValues(alpha: 0.5),
                fontSize: 14.sp,
                fontWeight: value ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
