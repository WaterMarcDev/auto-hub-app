import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBottomNav extends StatelessWidget {

  const OnboardingBottomNav({
    required this.currentIndex, 
    required this.pageCount, 
    required this.onNext,
    super.key,
  });
  final int currentIndex;
  final int pageCount;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentIndex == pageCount - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Page Indicators
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(pageCount, (index) {
            final isActive = index == currentIndex;
            return Container(
              margin: EdgeInsets.only(right: 8.w),
              width: isActive ? 24.w : 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.onboardingCyan
                    : Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.onboardingCyan
                              .withValues(alpha: 0.7),
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
            );
          }),
        ),

        // Next / Get Started Button
        GestureDetector(
          onTap: onNext,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.onboardingCyan,
                  AppColors.onboardingCyanDark,
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.onboardingCyan.withValues(alpha: 0.45),
                  blurRadius: 24.r,
                  offset: Offset(0, 6.h),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isLastPage ? 'Get Started' : 'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  
                  isLastPage ? AppIcons.arrowForward : AppIcons.chevronRight,
                  size: 18.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
