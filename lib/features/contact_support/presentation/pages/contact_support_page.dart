import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/constants/support_constants.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/call_support_dialog.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/email_support_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSupportHoursCard(),
                    SizedBox(height: 24.h),
                    _buildGetInTouchSection(context),
                    SizedBox(height: 24.h),
                    _buildRecentTicketsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(BuildContext context) async {
    final url = Uri(scheme: 'tel', path: SupportConstants.supportPhoneNumber);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Could not launch phone dialer')),
            );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Unable to open phone dialer at this time'),
            ),
          );
      }
    }
  }

  Future<void> _sendEmail(BuildContext context) async {
    final url = Uri(scheme: 'mailto', path: SupportConstants.supportEmail);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Could not launch email client')),
            );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Unable to open email client at this time'),
            ),
          );
      }
    }
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.colorWhite.withValues(alpha: 0.08),
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                AppIcons.chevronLeft,
                color: AppColors.colorWhite,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Contact Support',
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportHoursCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.onboardingGreen.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.onboardingGreen.withValues(alpha: 0.15),
          width: 0.8,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            AppIcons.accessTimeRounded,
            color: AppColors.onboardingGreen,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Support Hours',
                  style: TextStyle(
                    color: AppColors.onboardingGreen,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Mon-Fri 8AM-8PM · Sat 9AM-5PM CT',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onboardingTextSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetInTouchSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.onboardingTextSecondary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.onboardingSurfaceLight,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppColors.colorWhite.withValues(alpha: 0.07),
              width: 0.8,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              _ContactTile(
                icon: AppIcons.chatBubble,
                iconColor: AppColors.onboardingCyan,
                iconBgColor: AppColors.onboardingCyan.withValues(alpha: 0.1),
                title: 'Live Chat',
                subtitle: 'Avg. response: 2 min',
                showOnlineBadge: true,
                onTap: () {
                  context.pushNamed(
                    'chat-room',
                    pathParameters: {'chatRoomId': '1'},
                  );
                },
              ),
              Divider(
                color: AppColors.colorWhite.withValues(alpha: 0.05),
                height: 1.h,
              ),
              _ContactTile(
                icon: AppIcons.mailOutlineRounded,
                iconColor: AppColors.onboardingPurple,
                iconBgColor: AppColors.onboardingPurple.withValues(alpha: 0.1),
                title: 'Email Support',
                subtitle: SupportConstants.supportEmail,
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => EmailSupportDialog(
                      onConfirm: () => _sendEmail(context),
                    ),
                  );
                },
              ),
              Divider(
                color: AppColors.colorWhite.withValues(alpha: 0.05),
                height: 1.h,
              ),
              _ContactTile(
                icon: AppIcons.phoneOutline,
                iconColor: AppColors.onboardingGreen,
                iconBgColor: AppColors.onboardingGreen.withValues(alpha: 0.1),
                title: 'Phone Support',
                subtitle: SupportConstants.supportPhoneNumber,
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => CallSupportDialog(
                      onConfirm: () => _makePhoneCall(context),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTicketsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECENT TICKETS',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.onboardingTextSecondary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.h),
          decoration: BoxDecoration(
            color: AppColors.onboardingSurfaceLight,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppColors.colorWhite.withValues(alpha: 0.07),
              width: 0.8,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'No recent support tickets',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.showOnlineBadge = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool showOnlineBadge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.colorWhite,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (showOnlineBadge) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.onboardingGreen.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: AppColors.onboardingGreen.withValues(
                                  alpha: 0.2,
                                ),
                                width: 0.6,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 5.r,
                                  height: 5.r,
                                  decoration: const BoxDecoration(
                                    color: AppColors.onboardingGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'ONLINE',
                                  style: TextStyle(
                                    color: AppColors.onboardingGreen,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onboardingTextSecondary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                AppIcons.chevronRight,
                color: AppColors.colorWhite.withValues(alpha: 0.3),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
