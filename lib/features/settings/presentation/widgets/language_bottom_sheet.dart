import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({
    required this.selectedLanguage,
    required this.onLanguageSelected,
    super.key,
  });

  final String selectedLanguage;
  final void Function(String languageName, String flag) onLanguageSelected;

  static const List<Map<String, String>> languages = [
    {'name': 'English', 'flag': '🇺🇸'},
    {'name': 'Español', 'flag': '🇪🇸'},
    {'name': 'Français', 'flag': '🇫🇷'},
    {'name': 'Deutsch', 'flag': '🇩🇪'},
    {'name': 'Português', 'flag': '🇧🇷'},
    {'name': '中文', 'flag': '🇨🇳'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onboardingBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        border: Border(
          top: BorderSide(
            color: AppColors.colorWhite.withValues(alpha: 0.08),
            width: 0.8,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.colorLightGray,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 18.h),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Language',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.onboardingTextPrimary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: AppColors.onboardingSurface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.colorWhite.withValues(alpha: 0.07),
                      width: 0.8,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.colorWhite,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Language list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: languages.length,
            separatorBuilder: (context, index) => Divider(
              color: AppColors.colorWhite.withValues(alpha: 0.05),
              thickness: 0.8,
              height: 1.h,
            ),
            itemBuilder: (context, index) {
              final lang = languages[index];
              final name = lang['name']!;
              final flag = lang['flag']!;
              final isSelected = name == selectedLanguage;

              return InkWell(
                onTap: () {
                  onLanguageSelected(name, flag);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    children: [
                      Text(
                        flag,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Text(
                          name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.onboardingCyan
                                : AppColors.onboardingTextPrimary,
                            fontSize: 15.sp,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                      // Custom Radio style matching the design
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.onboardingCyan
                                : AppColors.colorLightGray,
                            width: 2.w,
                          ),
                        ),
                        padding: EdgeInsets.all(3.r),
                        child: isSelected
                            ? Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.onboardingCyan,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
