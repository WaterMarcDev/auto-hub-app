import 'dart:math' as math;

import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/account_details/presenatation/widgets/account_text_field.dart';
import 'package:auto_hub_app/features/account_details/presenatation/widgets/avatar_header.dart';
import 'package:auto_hub_app/features/account_details/presenatation/widgets/info_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EditAccountDetailsPage extends StatefulWidget {
  const EditAccountDetailsPage({super.key});

  @override
  State<EditAccountDetailsPage> createState() => _EditAccountDetailsPageState();
}

class _EditAccountDetailsPageState extends State<EditAccountDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Initial values
  final String _initialName = 'Mike Johnson';
  final String _initialEmail = 'mike.johnson@email.com';
  final String _initialPhone = '+1 (713) 555-0199';
  final String _initialLocation = 'Houston, TX';

  // Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;

  bool _isModified = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _initialName);
    _emailController = TextEditingController(text: _initialEmail);
    _phoneController = TextEditingController(text: _initialPhone);
    _locationController = TextEditingController(text: _initialLocation);

    // Listeners to track modifications
    _nameController.addListener(_checkModifications);
    _emailController.addListener(_checkModifications);
    _phoneController.addListener(_checkModifications);
    _locationController.addListener(_checkModifications);
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
    final nameChanged = _nameController.text != _initialName;
    final emailChanged = _emailController.text != _initialEmail;
    final phoneChanged = _phoneController.text != _initialPhone;
    final locationChanged = _locationController.text != _initialLocation;

    final modified = nameChanged || emailChanged || phoneChanged || locationChanged;

    if (modified != _isModified) {
      setState(() {
        _isModified = modified;
      });
    }
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _TopBar(
                onBackTap: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/account-details');
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
                        AvatarHeader(
                          initials: 'MJ',
                          isVerified: true,
                          showCameraIcon: true,
                          onCameraTap: () {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Change profile picture coming soon'),
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
                                if (value == null || value.trim().isEmpty) {
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
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email is required';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
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
                                if (value == null || value.trim().isEmpty) {
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
                                if (value == null || value.trim().isEmpty) {
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
                                onTap: () => context.pop(),
                                child: Container(
                                  height: 54.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF161B22),
                                    borderRadius: BorderRadius.circular(24.r),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.08),
                                      width: 0.8,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Cancel',
                                    style: AppTextStyles.labelLarge.copyWith(
                                      color: AppColors.onboardingTextPrimary,
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
                                onTap: _isModified ? _saveChanges : null,
                                child: Container(
                                  height: 54.h,
                                  decoration: BoxDecoration(
                                    color: _isModified
                                        ? AppColors.onboardingCyan
                                        : const Color(0xFF1C2330),
                                    borderRadius: BorderRadius.circular(24.r),
                                    border: Border.all(
                                      color: _isModified
                                          ? AppColors.onboardingCyan
                                          : Colors.white.withValues(alpha: 0.04),
                                      width: 0.8,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Save Changes',
                                    style: AppTextStyles.labelLarge.copyWith(
                                      color: _isModified
                                          ? Colors.white
                                          : const Color(0xFF484F58),
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
      ),
    );
  }
}
