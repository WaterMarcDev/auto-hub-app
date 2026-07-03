import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.message,
    required this.time,
    required this.isSender,
    this.isSent = true,
    super.key,
  });

  final String message;
  final String time;
  final bool isSender;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isSender ? 60.w : 16.w,
          right: isSender ? 16.w : 60.w,
          top: 6.h,
          bottom: 6.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSender
              ? AppColors.onboardingCyan
              : AppColors.onboardingSurfaceLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomLeft: isSender ? Radius.circular(20.r) : Radius.circular(4.r),
            bottomRight: isSender ? Radius.circular(4.r) : Radius.circular(20.r),
          ),
          border: isSender
              ? null
              : Border.all(
                  color: Colors.white.withValues(alpha: 0.04),
                  width: 0.8,
                ),
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            SizedBox(height: 6.h),
            if (isSender)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    isSent ? AppIcons.doneAll : AppIcons.done,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 14.sp,
                  ),
                ],
              )
            else
              Text(
                time,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.onboardingTextSecondary.withValues(
                    alpha: 0.5,
                  ),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
