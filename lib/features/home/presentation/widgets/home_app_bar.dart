import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      decoration: const BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        border: Border(
          bottom: BorderSide(
            color: Color(0x0FFFFFFF),
            width: 0.8,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Branding
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome back 👋',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textTertiary,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  // Gradient 'A' logo
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.onboardingCyan,
                          AppColors.onboardingCyanDark,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'A',
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.colorWhite,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'AutoHub Express',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onboardingTextPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Right: Bell + Avatar
          Row(
            children: [
              // Notification bell
              Stack(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.onboardingSurface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0x12FFFFFF),
                        width: 0.8,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/ic_home_bell.svg',
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                  ),
                  // Notification dot
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: AppColors.onboardingCyan,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.onboardingCyan.withValues(
                              alpha: 0.6,
                            ),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              // User avatar
              Container(
                width: 36.w,
                height: 36.h,
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
                      color: AppColors.onboardingCyan.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'AH',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.colorWhite,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
