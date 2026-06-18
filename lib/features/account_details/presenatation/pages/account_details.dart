import 'dart:math' as math;

import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/account_details/presenatation/widgets/avatar_header.dart';
import 'package:auto_hub_app/features/account_details/presenatation/widgets/detail_item_tile.dart';
import 'package:auto_hub_app/features/account_details/presenatation/widgets/info_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopBar(
              onBackTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
              onEditTap: () {
                context.push('/edit-account-details');
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
                      const AvatarHeader(
                        initials: 'MJ',
                        isVerified: true,
                      ),
                      SizedBox(height: 27.h),

                      // Personal Information Section
                      const InfoSectionCard(
                        title: 'Personal Information',
                        children: [
                          DetailItemTile(
                            label: 'Full Name',
                            value: 'Mike Johnson',
                          ),
                          DetailItemTile(
                            label: 'Email',
                            value: 'mike.johnson@email.com',
                          ),
                          DetailItemTile(
                            label: 'Phone',
                            value: '+1 (713) 555-0199',
                          ),
                          DetailItemTile(
                            label: 'Location',
                            value: 'Houston, TX',
                            showDivider: false,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Account Section
                      const InfoSectionCard(
                        title: 'Account',
                        children: [
                          DetailItemTile(
                            label: 'Member Since',
                            value: 'Jan 2024',
                          ),
                          DetailItemTile(
                            label: 'Account Type',
                            value: 'Verified Buyer',
                          ),
                          DetailItemTile(
                            label: 'User ID',
                            value: 'USR-48291',
                            showDivider: false,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Security Section
                      InfoSectionCard(
                        title: 'Security',
                        children: [
                          DetailItemTile(
                            label: 'Change Password',
                            value: 'Last changed\n3mo ago',
                            valueColor: AppColors.onboardingTextSecondary,
                            iconPath: AppIcons.shield,
                            iconColor: AppColors.onboardingPurple,
                            iconBackgroundColor:
                                AppColors.onboardingPurple.withValues(alpha: 0.1),
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text('Change Password coming soon'),
                                  ),
                                );
                            },
                          ),
                          DetailItemTile(
                            label: 'Delete Account',
                            iconPath: AppIcons.shield,
                            iconColor: AppColors.error,
                            iconBackgroundColor:
                                AppColors.error.withValues(alpha: 0.1),
                            labelColor: AppColors.error,
                            showDivider: false,
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text('Delete Account coming soon'),
                                  ),
                                );
                            },
                          ),
                        ],
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
  const _TopBar({
    required this.onBackTap,
    required this.onEditTap,
  });

  final VoidCallback onBackTap;
  final VoidCallback onEditTap;

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
                  child: Container(
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
                    child: SizedBox(
                      width: 16.w,
                      height: 16.h,
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
                ),
                SizedBox(width: 14.w),
                Text(
                  'Account Details',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onEditTap,
              child: Container(
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
                  colorFilter: const ColorFilter.mode(
                    AppColors.onboardingCyan,
                    BlendMode.srcIn,
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
