import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyPartsView extends StatelessWidget {
  const EmptyPartsView({
    super.key,
    required this.onClearFilters,
  });

  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60.h),
        Container(
          width: 88.r,
          height: 88.r,
          decoration: BoxDecoration(
            color: AppColors.surfaceDarkVariant,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppColors.colorWhite.withValues(alpha: 0.07),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.search,
            size: 40.r,
            color: AppColors.onboardingTextSecondary,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'No parts found',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.colorWhite,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Try adjusting your search or filters',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.onboardingTextSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        GestureDetector(
          onTap: onClearFilters,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.accentTeal,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentTeal.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Clear Filters',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.colorWhite,
              ),
            ),
          ),
        ),
        SizedBox(height: 60.h),
      ],
    );
  }
}
