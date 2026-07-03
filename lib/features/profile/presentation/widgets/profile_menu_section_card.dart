import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/profile/presentation/models/profile_menu_models.dart';
import 'package:auto_hub_app/features/profile/presentation/widgets/profile_menu_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuSectionCard extends StatelessWidget {
  const ProfileMenuSectionCard({
    required this.section,
    super.key,
  });

  final ProfileMenuSectionData section;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 19.h, 16.w, 8.h),
            child: Text(
              section.title,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textTertiary,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          for (var index = 0; index < section.items.length; index++)
            ProfileMenuItemTile(
              item: section.items[index],
              showDivider: index != section.items.length - 1,
            ),
        ],
      ),
    );
  }
}
