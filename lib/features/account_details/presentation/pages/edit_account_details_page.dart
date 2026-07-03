import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/account_details/data/repositories/account_repository.dart';
import 'package:auto_hub_app/features/account_details/domain/models/user_profile.dart';
import 'package:auto_hub_app/features/account_details/presentation/widgets/account_text_field.dart';
import 'package:auto_hub_app/features/account_details/presentation/widgets/avatar_header.dart';
import 'package:auto_hub_app/features/account_details/presentation/widgets/info_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditAccountDetailsPage extends StatefulWidget {
  const EditAccountDetailsPage({super.key});

  @override
  State<EditAccountDetailsPage> createState() => _EditAccountDetailsPageState();
}

class _EditAccountDetailsPageState extends State<EditAccountDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  UserProfile? _userProfile;
  bool _isLoading = true;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;

  bool _isModified = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _locationController = TextEditingController();

    _nameController.addListener(_checkModifications);
    _emailController.addListener(_checkModifications);
    _phoneController.addListener(_checkModifications);
    _locationController.addListener(_checkModifications);

    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await AccountRepository().getUserProfile();
    if (mounted) {
      setState(() {
        _userProfile = profile;
        _nameController.text = profile.fullName;
        _emailController.text = profile.email;
        _phoneController.text = profile.phone;
        _locationController.text = profile.location;
        _isLoading = false;
        // reset modified flag after loading initial data
        _isModified = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _checkModifications() {
    if (_userProfile == null) return;
    final nameChanged = _nameController.text != _userProfile!.fullName;
    final emailChanged = _emailController.text != _userProfile!.email;
    final phoneChanged = _phoneController.text != _userProfile!.phone;
    final locationChanged = _locationController.text != _userProfile!.location;

    final modified =
        nameChanged || emailChanged || phoneChanged || locationChanged;

    if (modified != _isModified) {
      setState(() {
        _isModified = modified;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_userProfile == null) return;

      final updatedProfile = _userProfile!.copyWith(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        location: _locationController.text,
      );

      await AccountRepository().updateUserProfile(updatedProfile);

      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Account details updated successfully'),
              backgroundColor: AppColors.success,
            ),
          );
        context.pop();
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (!_isModified) return true;
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.onboardingSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Unsaved Changes',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          'You have unsaved changes. Are you sure you want to discard them?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onboardingTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onboardingCyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Discard',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  Future<void> _handleBackTap() async {
    final canPop = await _onWillPop();
    if (canPop && mounted) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/account-details');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        body: SafeArea(
          bottom: false,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _TopBar(
                  onBackTap: _handleBackTap,
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
                                  showCameraIcon: true,
                                  onCameraTap: () {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Change profile picture coming soon',
                                          ),
                                        ),
                                      );
                                  },
                                ),
                                SizedBox(height: 27.h),

                                // Form Fields
                                InfoSectionCard(
                                  title: 'Personal Information',
                                  children: [
                                    AccountTextField(
                                      label: 'Full Name',
                                      controller: _nameController,
                                      hintText: 'Enter your full name',
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Full name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    AccountTextField(
                                      label: 'Email Address',
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: 'Enter your email address',
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Email is required';
                                        }
                                        if (!RegExp(
                                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                        ).hasMatch(value)) {
                                          return 'Enter a valid email address';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    AccountTextField(
                                      label: 'Phone Number',
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      hintText: 'Enter your phone number',
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Phone number is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    AccountTextField(
                                      label: 'Location',
                                      controller: _locationController,
                                      hintText: 'Enter your location',
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Location is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 32.h),

                                // Action Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: _handleBackTap,
                                        child: Container(
                                          height: 54.h,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF161B22),
                                            borderRadius: BorderRadius.circular(
                                              24.r,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withValues(
                                                alpha: 0.08,
                                              ),
                                              width: 0.8,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Cancel',
                                            style: AppTextStyles.labelLarge
                                                .copyWith(
                                                  color: AppColors
                                                      .onboardingTextPrimary,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 14.w),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: _isModified
                                            ? _saveChanges
                                            : null,
                                        child: Container(
                                          height: 54.h,
                                          decoration: BoxDecoration(
                                            color: _isModified
                                                ? AppColors.onboardingCyan
                                                : const Color(0xFF1C2330),
                                            borderRadius: BorderRadius.circular(
                                              24.r,
                                            ),
                                            border: Border.all(
                                              color: _isModified
                                                  ? AppColors.onboardingCyan
                                                  : Colors.white.withValues(
                                                      alpha: 0.04,
                                                    ),
                                              width: 0.8,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Save Changes',
                                            style: AppTextStyles.labelLarge
                                                .copyWith(
                                                  color: _isModified
                                                      ? Colors.white
                                                      : AppColors.textTertiary,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                      ),
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
                  AppIcons.chevronLeft,
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
      ),
    );
  }
}
