import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/account_details/data/repositories/account_repository.dart';
import 'package:auto_hub_app/features/account_details/domain/models/user_profile.dart';
import 'package:auto_hub_app/features/account_details/presentation/widgets/avatar_header.dart';
import 'package:auto_hub_app/features/account_details/presentation/widgets/detail_item_tile.dart';
import 'package:auto_hub_app/features/account_details/presentation/widgets/info_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  UserProfile? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    final profile = await AccountRepository().getUserProfile();
    if (mounted) {
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
    }
  }

  String _maskUserId(String userId) {
    if (userId.length <= 4) return userId;
    return '${userId.substring(0, 4)}****${userId.substring(userId.length - 2)}';
  }

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
              onEditTap: () async {
                await context.push('/edit-account-details');
                _loadProfile(); // Reload after edit
              },
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.onboardingCyan,
                      ),
                    )
                  : _userProfile == null
                  ? Center(
                      child: Text(
                        'Failed to load profile',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 18.h),
                            AvatarHeader(
                              initials: _userProfile!.initials,
                              isVerified: _userProfile!.isVerified,
                            ),
                            SizedBox(height: 27.h),

                            // Personal Information Section
                            InfoSectionCard(
                              title: 'Personal Information',
                              children: [
                                DetailItemTile(
                                  label: 'Full Name',
                                  value: _userProfile!.fullName,
                                ),
                                DetailItemTile(
                                  label: 'Email',
                                  value: _userProfile!.email,
                                ),
                                DetailItemTile(
                                  label: 'Phone',
                                  value: _userProfile!.phone,
                                ),
                                DetailItemTile(
                                  label: 'Location',
                                  value: _userProfile!.location,
                                  showDivider: false,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Account Section
                            InfoSectionCard(
                              title: 'Account',
                              children: [
                                DetailItemTile(
                                  label: 'Member Since',
                                  value: _userProfile!.memberSince,
                                ),
                                DetailItemTile(
                                  label: 'Account Type',
                                  value: _userProfile!.accountType,
                                ),
                                DetailItemTile(
                                  label: 'User ID',
                                  value: _maskUserId(_userProfile!.id),
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
                                  iconBackgroundColor: AppColors
                                      .onboardingPurple
                                      .withValues(alpha: 0.1),
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Change Password coming soon',
                                          ),
                                        ),
                                      );
                                  },
                                ),
                                DetailItemTile(
                                  label: 'Delete Account',
                                  iconPath: AppIcons.shield,
                                  iconColor: AppColors.error,
                                  iconBackgroundColor: AppColors.error
                                      .withValues(alpha: 0.1),
                                  labelColor: AppColors.error,
                                  showDivider: false,
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Delete Account coming soon',
                                          ),
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
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 16.w,
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
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.edit_outlined,
                    color: AppColors.onboardingCyan,
                    size: 15.w,
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
