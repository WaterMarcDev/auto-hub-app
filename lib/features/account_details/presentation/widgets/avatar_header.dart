import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarHeader extends StatelessWidget {
  const AvatarHeader({
    required this.initials,
    this.isVerified = true,
    this.showCameraIcon = false,
    this.onCameraTap,
    super.key,
  });

  final String initials;
  final bool isVerified;
  final bool showCameraIcon;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 88.w,
          height: 88.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Avatar box with initials
              Container(
                width: 88.w,
                height: 88.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.onboardingCyan,
                      AppColors.onboardingCyanDark,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.onboardingSurface,
                    width: 3.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.onboardingCyan.withValues(alpha: 0.4),
                      blurRadius: 20.r,
                      offset: Offset(0, 6.h),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),

              // Camera overlay button (for edit page)
              if (showCameraIcon)
                Positioned(
                  right: -4.w,
                  bottom: -4.h,
                  child: GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C2330),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.onboardingBackground,
                          width: 2.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 6.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.onboardingCyan,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (isVerified) ...[
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.profileVerified,
                width: 14.w,
                height: 14.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.onboardingGreen,
                  BlendMode.srcIn,
                ),
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
              SizedBox(width: 6.w),
              Text(
                'Verified Account',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onboardingGreen,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
