import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingsTopBar extends StatelessWidget {
  const SettingsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.onboardingSurface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.colorWhite.withValues(alpha: 0.07),
                    width: 0.8,
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  AppIcons.arrowLeft,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Text(
              'Settings',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.onboardingTextPrimary,
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}