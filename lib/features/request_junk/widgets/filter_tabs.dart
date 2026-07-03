import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A horizontal scrollable list of filter tabs.
class FilterTabs extends StatelessWidget {
  /// Creates a [FilterTabs] widget.
  const FilterTabs({
    required this.tabs,
    required this.selectedTab,
    required this.onTabSelected,
    super.key,
  });

  /// The list of tabs to display.
  final List<String> tabs;

  /// The currently selected tab.
  final String selectedTab;

  /// Callback when a tab is selected.
  final ValueChanged<String> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isActive = selectedTab == tab;
          return GestureDetector(
            onTap: () => onTabSelected(tab),
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.onboardingCyan.withValues(alpha: 0.1)
                    : AppColors.onboardingSurface,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isActive
                      ? AppColors.onboardingCyan
                      : AppColors.colorWhite.withValues(alpha: 0.08),
                  width: 1.0,
                ),
              ),
              child: Text(
                tab,
                style: AppTextStyles.labelLarge.copyWith(
                  color: isActive
                      ? AppColors.onboardingCyan
                      : AppColors.onboardingTextSecondary,
                  fontSize: 14.sp,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
