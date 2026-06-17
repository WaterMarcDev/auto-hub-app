import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 1: Tell us about your vehicle.
class StepVehicleInfo extends StatelessWidget {
  /// Creates a [StepVehicleInfo] widget.
  const StepVehicleInfo({
    required this.yearController,
    required this.makeController,
    required this.modelController,
    required this.vinController,
    required this.onChanged,
    super.key,
  });

  /// Controller for the vehicle year input.
  final TextEditingController yearController;

  /// Controller for the vehicle make input.
  final TextEditingController makeController;

  /// Controller for the vehicle model input.
  final TextEditingController modelController;

  /// Controller for the vehicle VIN input.
  final TextEditingController vinController;

  /// Callback when any of the text fields change.
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell us about your vehicle',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 24.h),
          _buildLabel('YEAR'),
          _buildTextField(
            controller: yearController,
            hintText: 'e.g. 2010',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            onChanged: (_) => onChanged(),
          ),
          SizedBox(height: 20.h),
          _buildLabel('MAKE'),
          _buildTextField(
            controller: makeController,
            hintText: 'e.g. Honda',
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => onChanged(),
          ),
          SizedBox(height: 20.h),
          _buildLabel('MODEL'),
          _buildTextField(
            controller: modelController,
            hintText: 'e.g. Civic',
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => onChanged(),
          ),
          SizedBox(height: 20.h),
          _buildLabel('VIN (OPTIONAL)'),
          _buildTextField(
            controller: vinController,
            hintText: '17-digit VIN number',
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              LengthLimitingTextInputFormatter(17),
            ],
            onChanged: (_) => onChanged(),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onboardingTextPrimary,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColors.onboardingCyan,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
            fontSize: 15.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(
              color: AppColors.onboardingCyan,
              width: 1.5,
            ),
          ),
          filled: false,
        ),
      ),
    );
  }
}
