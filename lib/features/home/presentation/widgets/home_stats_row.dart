import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _StatCard(
            value: '18K+',
            label: 'Parts Listed',
            color: AppColors.onboardingCyan,
          ),
          SizedBox(width: 11.w),
          _StatCard(
            value: '320+',
            label: 'Yards',
            color: AppColors.onboardingGreen,
          ),
          SizedBox(width: 11.w),
          _StatCard(
            value: '94K+',
            label: 'Buyers',
            color: AppColors.onboardingPurple,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 72.h,
        decoration: BoxDecoration(
          color: AppColors.onboardingSurfaceLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.colorWhite.withValues(alpha: 0.07),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
