import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: SizedBox(
          height: 184.h,
          width: double.infinity,
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/home_banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xCC000000),
                        Color(0x80000000),
                        Color(0x33000000),
                      ],
                      stops: [0.077, 0.542, 0.923],
                    ),
                  ),
                ),
              ),
              // Content
              Positioned(
                left: 20,
                right: 20,
                top: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: badge + view all
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Badge
                        Container(
                          height: 34.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: 
                              AppColors.onboardingCyan
                            .withValues(alpha: 0.13),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: 
                                AppColors.onboardingCyan
                              .withValues(alpha: 0.33),
                              width: 0.8,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Top Salvage Yard',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onboardingCyan,
                            ),
                          ),
                        ),
                        // View all
                        Row(
                          children: [
                            Text(
                              'View all',
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.colorWhite.withValues(alpha: 0.6),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            SvgPicture.asset(
                              'assets/icons/ic_arrow_up_right.svg',
                              width: 12.w,
                              height: 12.h,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      'Quality Used Parts',
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.colorWhite,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Subtitle
                    Text(
                      'Houston, TX · Over 5,000 parts',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorWhite.withValues(alpha: 0.55),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    // Browse parts button
                    Container(
                      height: 34.h,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.onboardingCyan, AppColors.onboardingCyanDark],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: 
                              AppColors.onboardingCyan
                            .withValues(alpha: 0.45),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Browse Parts',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.colorWhite,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            'assets/icons/ic_chevron_right.svg',
                            width: 12.w,
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Carousel dots
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Active dot
                    Container(
                      width: 6.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: AppColors.onboardingCyan,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: 
                              AppColors.onboardingCyan
                            .withValues(alpha: 0.8),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
