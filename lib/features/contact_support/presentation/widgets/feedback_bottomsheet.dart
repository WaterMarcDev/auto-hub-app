import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({
    this.onSubmit,
    super.key,
  });

  final ValueChanged<double>? onSubmit;

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  double _currentRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        border: Border(
          top: BorderSide(
            color: AppColors.colorWhite.withValues(alpha: 0.08),
            width: 0.8,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle at top center
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.colorWhite.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 18.h),
          // Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rate Your Experience',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.colorWhite,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: AppColors.colorWhite.withValues(alpha: 0.04),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.colorWhite.withValues(alpha: 0.05),
                      width: 0.8,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    AppIcons.close,
                    color: AppColors.colorWhite.withValues(alpha: 0.7),
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Soft rounded cyan headphone/support icon
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              color: AppColors.onboardingCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(18.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              AppIcons.headphonesOutlined,
              color: AppColors.onboardingCyan,
              size: 30.sp,
            ),
          ),
          SizedBox(height: 20.h),
          // Text prompt
          Text(
            'How was your support experience?',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          // Custom Stars Rating widget
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentRating = starIndex.toDouble();
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Icon(
                    starIndex <= _currentRating
                        ? AppIcons.starRounded
                        : AppIcons.starOutlineRounded,
                    color: AppColors.onboardingCyan,
                    size: 40.sp,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 32.h),
          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: _currentRating == 0.0
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      if (widget.onSubmit != null) {
                        widget.onSubmit!(_currentRating);
                      }
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              'Thank you for your rating of ${_currentRating.toInt()} stars!',
                            ),
                          ),
                        );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.onboardingCyan,
                foregroundColor: AppColors.colorWhite,
                disabledBackgroundColor: AppColors.onboardingSurfaceLight,
                disabledForegroundColor: AppColors.colorWhite.withValues(alpha: 0.15),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  side: _currentRating == 0.0
                      ? BorderSide(
                          color: AppColors.colorWhite.withValues(alpha: 0.04),
                          width: 0.8,
                        )
                      : BorderSide.none,
                ),
              ),
              child: Text(
                'Submit Rating',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
