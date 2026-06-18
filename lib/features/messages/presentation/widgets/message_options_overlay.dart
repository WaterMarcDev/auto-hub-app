import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageOptionsOverlay extends StatelessWidget {
  const MessageOptionsOverlay({
    required this.onMarkAllAsRead,
    required this.onDeleteAll,
    super.key,
  });

  final VoidCallback onMarkAllAsRead;
  final VoidCallback onDeleteAll;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.topRight,
      insetPadding: EdgeInsets.only(
        top: 54.h + topPadding,
        right: 20.w,
      ),
      child: SizedBox(
        width: 250.w,
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
          decoration: BoxDecoration(
            color: AppColors.onboardingSurface,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 24.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Message Options',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 18.h),
              _OptionTile(
                icon: Icons.done_all,
                iconColor: AppColors.onboardingCyan,
                title: 'Mark All as Read',
                titleColor: Colors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onMarkAllAsRead();
                },
              ),
              SizedBox(height: 8.h),
              _OptionTile(
                icon: Icons.delete_outline_rounded,
                iconColor: AppColors.error,
                title: 'Delete All Conversations',
                titleColor: AppColors.error,
                onTap: () {
                  Navigator.of(context).pop();
                  onDeleteAll();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.titleColor,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 22.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: titleColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
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
