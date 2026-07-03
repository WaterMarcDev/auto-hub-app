import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeJunkCarBanner extends StatelessWidget {
  const HomeJunkCarBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.onboardingCyan.withValues(alpha: 0.2),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.onboardingCyan.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Background gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.81, -1.0),
                    end: Alignment(0.81, 1.0),
                    colors: [
                      AppColors.gradientDarkMid,
                      AppColors.gradientDarkSurface,
                    ],
                  ),
                ),
              ),
            ),
            // Radial glow (top-right)
            Positioned(
              right: -24,
              top: -38,
              child: Container(
                width: 128.w,
                height: 128.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.onboardingCyan.withValues(alpha: 0.15),
                      AppColors.glowTeal.withValues(alpha: 0.075),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.35, 0.7],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Label
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_wrench_junk.svg',
                              width: 12.w,
                              height: 12.h,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'JUNK YOUR CAR',
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onboardingCyan,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        // Headline
                        Text(
                          'Turn your wreck\ninto cash',
                          style: GoogleFonts.inter(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.colorWhite,
                            letterSpacing: -0.3,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        // Sub text
                        Text(
                          'Free towing · Instant cash offer',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.colorWhite.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // CTA button
                  Container(
                    height: 44.h,
                    width: 98.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.onboardingCyan,
                          AppColors.onboardingCyan,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.onboardingCyan.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Get Offer',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.colorWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
