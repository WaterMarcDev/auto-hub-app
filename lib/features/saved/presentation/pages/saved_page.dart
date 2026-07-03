import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({required this.onBrowseTap, super.key});

  final VoidCallback onBrowseTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.onboardingBackground,
                    AppColors.gradientDarkAlt1,
                    AppColors.gradientDarkAlt2,
                  ],
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
          ),

          // Ambient glow behind the empty-state icon cluster
          Positioned(
            top: 70.h,
            left: 74.w,
            child: Container(
              width: 212.w,
              height: 212.h,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.onboardingCyan.withValues(alpha: 0.16),
                    AppColors.onboardingCyan.withValues(alpha: 0.0),
                  ],
                  stops: [0, 1],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -38.h,
            left: 0,
            right: 0,
            child: Container(
              height: 130.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.onboardingCyan.withValues(alpha: 0.0),
                    AppColors.onboardingCyan.withValues(alpha: 0.12),
                    AppColors.onboardingCyan.withValues(alpha: 0.0),
                  ],
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  height: 76.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.onboardingSurfaceLight,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.colorWhite.withValues(alpha: 0.06),
                        width: 0.8,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0.8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My wishlist',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      Text(
                        'Saved Parts',
                        style: GoogleFonts.inter(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.onboardingTextPrimary,
                          height: 1.5,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 384.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 70.h,
                        left: 124.w,
                        child: SizedBox(
                          width: 112.w,
                          height: 112.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 112.w,
                                height: 112.h,
                                decoration: BoxDecoration(
                                  color: AppColors.onboardingCyan.withValues(
                                    alpha: 0.06,
                                  ),
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color: AppColors.onboardingCyan.withValues(
                                      alpha: 0.12,
                                    ),
                                    width: 0.8,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.onboardingCyan
                                          .withValues(alpha: 0.08),
                                      blurRadius: 40,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/icons/ic_saved_heart_empty.svg',
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              ),
                              Positioned(
                                right: -8.w,
                                top: -8.h,
                                child: Container(
                                  width: 32.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.onboardingCyan.withValues(
                                      alpha: 0.05,
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.onboardingCyan
                                          .withValues(alpha: 0.1),
                                      width: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -8.w,
                                bottom: -8.h,
                                child: Container(
                                  width: 20.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.onboardingCyan.withValues(
                                      alpha: 0.04,
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.onboardingCyan
                                          .withValues(alpha: 0.08),
                                      width: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 206.2.h,
                        left: 0,
                        right: 0,
                        child: Text(
                          'No saved parts yet',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onboardingTextPrimary,
                            height: 1.5,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 247.2.h,
                        left: 62.w,
                        right: 62.w,
                        child: Text(
                          'Tap the ♥ on any part listing to\nsave it to your wishlist',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onboardingTextSecondary,
                            height: 1.7,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 316.2.h,
                        left: 83.w,
                        child: GestureDetector(
                          onTap: onBrowseTap,
                          child: Container(
                            width: 194.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              gradient: const LinearGradient(
                                begin: Alignment(-0.62, -1.0),
                                end: Alignment(0.62, 1.0),
                                colors: [
                                  AppColors.onboardingCyan,
                                  AppColors.onboardingCyanDark,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.onboardingCyan.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 24,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_saved_wrench.svg',
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Browse Parts',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.colorWhite,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                SvgPicture.asset(
                                  'assets/icons/ic_saved_arrow_right.svg',
                                  width: 16.w,
                                  height: 16.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
