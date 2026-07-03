import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/help_center/models/help_article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpArticleTile extends StatelessWidget {
  final HelpArticle article;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool? wasHelpful;
  final Function(bool) onFeedback;

  const HelpArticleTile({
    super.key,
    required this.article,
    required this.isExpanded,
    required this.onToggle,
    required this.wasHelpful,
    required this.onFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header (Togglable)
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          article.title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.onboardingCyan.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: AppColors.onboardingCyan.withValues(
                              alpha: 0.2,
                            ),
                            width: 0.6,
                          ),
                        ),
                        child: Text(
                          article.category,
                          style: TextStyle(
                            color: AppColors.onboardingCyan,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  isExpanded
                      ? AppIcons.keyboardArrowDownRounded
                      : AppIcons.chevronRightRounded,
                  color: isExpanded
                      ? AppColors.onboardingCyan
                      : Colors.white.withValues(alpha: 0.3),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),

        // Animated Body
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                  ),
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.onboardingBackground,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.content,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 13.5.sp,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Text(
                            'Was this helpful?',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.onboardingTextSecondary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          _buildFeedbackButton(
                            label: 'Yes',
                            isSelected: wasHelpful == true,
                            isAnySelected: wasHelpful != null,
                            color: AppColors.onboardingGreen,
                            onTap: () => onFeedback(true),
                          ),
                          SizedBox(width: 10.w),
                          _buildFeedbackButton(
                            label: 'No',
                            isSelected: wasHelpful == false,
                            isAnySelected: wasHelpful != null,
                            color: AppColors.error,
                            onTap: () => onFeedback(false),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox(width: double.infinity, height: 0),
        ),
      ],
    );
  }

  Widget _buildFeedbackButton({
    required String label,
    required bool isSelected,
    required bool isAnySelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    final double opacity = isSelected
        ? 0.15
        : (isAnySelected ? 0.02 : 0.05);
    final double borderOpacity = isSelected
        ? 0.4
        : (isAnySelected ? 0.05 : 0.15);
    final Color textColor = isSelected
        ? color
        : (isAnySelected ? color.withValues(alpha: 0.3) : color);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: color.withValues(alpha: borderOpacity),
            width: 0.8,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
