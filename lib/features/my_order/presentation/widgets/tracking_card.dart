import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackingCard extends StatelessWidget {
  const TrackingCard({required this.trackingNumber, super.key});

  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.07),
          width: 0.8,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TRACKING NUMBER',
                  style: GoogleFonts.inter(
                    color: AppColors.onboardingTextSecondary,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  trackingNumber,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: trackingNumber));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'Tracking number copied to clipboard',
                      style: GoogleFonts.inter(color: AppColors.colorWhite),
                    ),
                    backgroundColor: AppColors.primary,
                    duration: const Duration(seconds: 2),
                  ),
                );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.copy_rounded,
                  size: 14.sp,
                  color: AppColors.onboardingCyan,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Copy',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.onboardingCyan,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
