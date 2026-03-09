import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatelessWidget {

  const AuthTextField({
    required this.hintText, required this.prefixIcon, super.key,
    this.isPassword = false,
    this.suffixIconPath,
    this.suffixIconPathActive,
  });
  final String hintText;
  final Widget prefixIcon;
  final bool isPassword;
  final String? suffixIconPath;
  final String? suffixIconPathActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(16.41),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.82,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4.1,
            offset: const Offset(0, 1.03),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.2, vertical: 0.82),
      child: Row(
        children: [
          Container(
            width: 28.7,
            height: 28.7,
            decoration: BoxDecoration(
              color: AppColors.onboardingCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14.36),
            ),
            padding: const EdgeInsets.all(7),
            child: prefixIcon,
          ),
          const SizedBox(width: 12.3),
          Expanded(
            child: TextField(
              obscureText: isPassword,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onboardingTextPrimary,
                fontSize: 14.36,
              ),
              cursorColor: AppColors.onboardingCyan,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onboardingTextPrimary.withValues(alpha: 0.5),
                  fontSize: 14.36,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          if (isPassword && suffixIconPath != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SizedBox(
                width: 16.4,
                height: 16.4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(suffixIconPath!),
                    if (suffixIconPathActive != null)
                      SvgPicture.asset(suffixIconPathActive!),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
