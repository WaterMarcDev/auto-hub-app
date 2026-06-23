import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/messages/domain/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    required this.conversation,
    required this.onTap,
    super.key,
  });

  final LiveChatConversation conversation;
  final VoidCallback onTap;

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
              _buildAvatar(),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          conversation.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          conversation.time,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onboardingTextSecondary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            conversation.lastMessage,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.onboardingTextSecondary,
                              fontSize: 13.sp,
                              height: 1.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation.unreadCount > 0) ...[
                          SizedBox(width: 8.w),
                          Container(
                            width: 20.r,
                            height: 20.r,
                            decoration: const BoxDecoration(
                              color: AppColors.onboardingCyan,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${conversation.unreadCount}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 44.r,
      height: 44.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: conversation.avatarColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.center,
            child: Text(
              conversation.initials,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          if (conversation.isOnline)
            Positioned(
              right: -2.r,
              bottom: -2.r,
              child: Container(
                width: 14.r,
                height: 14.r,
                decoration: BoxDecoration(
                  color: AppColors.onboardingGreen,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.onboardingSurfaceLight,
                    width: 2.0.r,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
