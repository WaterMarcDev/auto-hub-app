import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.onboardingSurfaceLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.colorWhite.withValues(alpha: 0.08),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 14.w),
            Icon(
              AppIcons.search,
              color: AppColors.onboardingTextPrimary.withValues(alpha: 0.5),
              size: 16,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Search part name, make, model...',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onboardingTextPrimary.withValues(alpha: 0.5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            // Search button
            Container(
              width: 68.w,
              height: 30.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.6, -1.0),
                  end: Alignment(0.6, 1.0),
                  colors: [
                    AppColors.onboardingCyan,
                    AppColors.onboardingCyanDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.onboardingCyan.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'Search',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.colorWhite,
                ),
              ),
            ),
            SizedBox(width: 4.w),
          ],
        ),
      ),
    );
  }
}
