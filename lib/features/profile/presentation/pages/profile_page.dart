import 'dart:math' as math;

import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/profile/presentation/models/profile_menu_models.dart';
import 'package:auto_hub_app/features/profile/presentation/widgets/profile_menu_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  List<ProfileMenuSectionData> _buildSections(BuildContext context, VoidCallback onMenuTap) {
    return [
      ProfileMenuSectionData(
        title: 'MY ACTIVITY',
        items: [
          ProfileMenuItemData(
            title: 'My Orders',
            iconPath: AppIcons.profileActivity,
            iconBackgroundColor: const Color(0x1F0DA0CE),
            onTap: onMenuTap,
          ),
          ProfileMenuItemData(
            title: 'Saved Parts',
            iconPath: AppIcons.profileHeart,
            iconBackgroundColor: const Color(0x1FA78BFA),
            onTap: onMenuTap,
          ),
          ProfileMenuItemData(
            title: 'My Junk Requests',
            iconPath: AppIcons.profileCard,
            iconBackgroundColor: const Color(0x1F34D399),
            onTap: onMenuTap,
          ),
          ProfileMenuItemData(
            title: 'Messages',
            iconPath: AppIcons.profileChat,
            iconBackgroundColor: const Color(0x1FFBBF24),
            onTap: onMenuTap,
          ),
        ],
      ),
      ProfileMenuSectionData(
        title: 'ACCOUNT INFO',
        items: [
          ProfileMenuItemData(
            title: 'Account Details',
            iconPath: AppIcons.profileActivity,
            iconBackgroundColor: const Color(0x1F0DA0CE),
            onTap: onMenuTap,
          ),
          ProfileMenuItemData(
            title: 'Your Addresses',
            iconPath: AppIcons.profileHeart,
            iconBackgroundColor: const Color(0x1FA78BFA),
            onTap: () => context.push('/your-addresses'),
          ),
          ProfileMenuItemData(
            title: 'Payment Methods',
            iconPath: AppIcons.profileCard,
            iconBackgroundColor: const Color(0x1F34D399),
            onTap: onMenuTap,
          ),
          ProfileMenuItemData(
            title: 'Settings',
            iconPath: AppIcons.profileSettings,
            iconBackgroundColor: const Color(0x1A8B929A),
            onTap: onMenuTap,
          ),
        ],
      ),
      ProfileMenuSectionData(
        title: 'SUPPORT',
        items: [
          ProfileMenuItemData(
            title: 'Help Center',
            iconPath: AppIcons.profileHelp,
            iconBackgroundColor: const Color(0x1F60A5FA),
            onTap: onMenuTap,
          ),
          ProfileMenuItemData(
            title: 'Contact Support',
            iconPath: AppIcons.profileChat,
            iconBackgroundColor: const Color(0x1FFBBF24),
            onTap: onMenuTap,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections(context, () {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('This section is coming soon')),
        );
    });

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopBar(
              onBackTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 18.h),
                      const _ProfileIdentityHeader(
                        name: 'Mike Johnson',
                        initials: 'MJ',
                      ),
                      SizedBox(height: 27.h),
                      for (var index = 0; index < sections.length; index++)
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: ProfileMenuSectionCard(
                            section: sections[index],
                          ),
                        ),
                      _SignOutButton(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Sign out action coming soon',
                                ),
                              ),
                            );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'AutoHub Express v2.4.1 · Salvage & Parts',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: const Color(0xFF2D333B),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBackTap});

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onBackTap,
                  child: SizedBox(
                    width: 18.75.w,
                    height: 18.75.h,
                    child: Transform.rotate(
                      angle: math.pi,
                      child: SvgPicture.asset(
                        AppIcons.chevronRight,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Text(
                  'Profile',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.07),
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppIcons.profileEdit,
                width: 15.w,
                height: 15.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileIdentityHeader extends StatelessWidget {
  const _ProfileIdentityHeader({
    required this.name,
    required this.initials,
  });

  final String name;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 72.w,
          height: 64.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 64.w,
                  height: 64.h,
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
                    border: Border.all(
                      color: AppColors.onboardingSurface,
                      width: 2.4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.onboardingCyan.withValues(alpha: 0.4),
                        blurRadius: 16.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initials,
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 4.w,
                bottom: -4.h,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.onboardingGreen,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.onboardingSurface,
                      width: 1.6,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: AppColors.onboardingBackground,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          name,
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.onboardingTextPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 20.h,
          padding: EdgeInsets.fromLTRB(10.w, 0.6.h, 10.w, 0.6.h),
          decoration: BoxDecoration(
            color: AppColors.onboardingGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.5.r),
            border: Border.all(
              color: AppColors.onboardingGreen.withValues(alpha: 0.2),
              width: 0.6,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.profileVerified,
                width: 9.w,
                height: 9.h,
              ),
              SizedBox(width: 4.5.w),
              Text(
                'VERIFIED',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onboardingGreen,
                  fontSize: 7.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          width: double.infinity,
          height: 54.6.h,
          decoration: BoxDecoration(
            color: AppColors.onboardingCyan.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppColors.onboardingCyan.withValues(alpha: 0.14),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.profileLogout,
                width: 15.w,
                height: 15.h,
              ),
              SizedBox(width: 10.w),
              Text(
                'Sign Out',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.onboardingCyan,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
