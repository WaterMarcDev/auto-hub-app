import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum PartBadgeType { featured, hotDeal, certified, none }

enum PartCondition { excellent, good }

class PartItemData {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final String category;
  final String warranty;
  final String location;
  final double rating;
  final PartBadgeType badge;
  final PartCondition condition;

  const PartItemData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.category,
    required this.warranty,
    required this.location,
    required this.rating,
    required this.badge,
    required this.condition,
  });
}

/// Horizontal card used in "Featured Parts" horizontal scroll.
class HomePartCardHorizontal extends StatelessWidget {
  final PartItemData item;
  final double width;

  const HomePartCardHorizontal({
    super.key,
    required this.item,
    this.width = 284,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: 248.h,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.07),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          // Image section
          _PartImageSection(item: item, height: 150),
          // Info section
          Expanded(
            child: _PartInfoSection(item: item),
          ),
        ],
      ),
    );
  }
}

/// Vertical card used in "Recent Listings" vertical list.
class HomePartCardVertical extends StatelessWidget {
  final PartItemData item;

  const HomePartCardVertical({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.onboardingSurfaceLight,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.colorWhite.withValues(alpha: 0.07),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            // Image section (taller for vertical cards)
            _PartImageSection(item: item, height: 195),
            // Info section
            _PartInfoSection(item: item),
          ],
        ),
      ),
    );
  }
}

class _PartImageSection extends StatelessWidget {
  final PartItemData item;
  final double height;

  const _PartImageSection({required this.item, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Image
          Positioned.fill(
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.colorBlack.withValues(alpha: 0.1),
                    Colors.transparent,
                    AppColors.colorBlack.withValues(alpha: 0.7),
                  ],
                  stops: [0.0, 0.35, 1.0],
                ),
              ),
            ),
          ),
          // Badge (top-left)
          if (item.badge != PartBadgeType.none)
            Positioned(
              top: 12,
              left: 12,
              child: _BadgeWidget(badge: item.badge),
            ),
          // Heart button (top-right)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColors.onboardingBackground.withValues(alpha: 0.7),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.colorWhite.withValues(alpha: 0.12),
                  width: 0.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/ic_heart.svg',
                width: 14.w,
                height: 14.h,
              ),
            ),
          ),
          // Price + condition (bottom)
          Positioned(
            left: 12,
            right: 12,
            bottom: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.price,
                  style: GoogleFonts.inter(
                    fontSize: height > 150 ? 19.sp : 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.colorWhite,
                    letterSpacing: -0.5,
                  ),
                ),
                _ConditionBadge(condition: item.condition),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeWidget extends StatelessWidget {
  final PartBadgeType badge;

  const _BadgeWidget({required this.badge});

  @override
  Widget build(BuildContext context) {
    switch (badge) {
      case PartBadgeType.featured:
        return Container(
          height: 33.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: AppColors.onboardingCyan.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.facebookBlue.withValues(alpha: 0.21),
              width: 0.8,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'Featured',
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.onboardingCyan,
              letterSpacing: 0.5,
            ),
          ),
        );
      case PartBadgeType.hotDeal:
        return Container(
          height: 33.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: AppColors.onboardingCyan.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.onboardingCyan.withValues(alpha: 0.21),
              width: 0.8,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '🔥 Hot Deal',
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.onboardingCyan,
              letterSpacing: 0.5,
            ),
          ),
        );
      case PartBadgeType.certified:
        return Container(
          height: 33.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: AppColors.certifiedGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.onboardingGreen.withValues(alpha: 0.21),
              width: 0.8,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '✓ Certified',
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.onboardingGreen,
              letterSpacing: 0.5,
            ),
          ),
        );
      case PartBadgeType.none:
        return const SizedBox.shrink();
    }
  }
}

class _ConditionBadge extends StatelessWidget {
  final PartCondition condition;

  const _ConditionBadge({required this.condition});

  @override
  Widget build(BuildContext context) {
    final isExcellent = condition == PartCondition.excellent;
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.onboardingBackground.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isExcellent
              ? AppColors.onboardingGreen.withValues(alpha: 0.21)
              : AppColors.onboardingCyan.withValues(alpha: 0.21),
          width: 0.8,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        isExcellent ? 'Excellent' : 'Good',
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: isExcellent
              ? AppColors.onboardingGreen
              : AppColors.onboardingCyan,
        ),
      ),
    );
  }
}

class _PartInfoSection extends StatelessWidget {
  final PartItemData item;

  const _PartInfoSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onboardingTextPrimary,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_tag.svg',
                          width: 10.w,
                          height: 10.h,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          item.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onboardingTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Rating
              Container(
                height: 24.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.starRating.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_star.svg',
                      width: 11.w,
                      height: 11.h,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      item.rating.toStringAsFixed(1),
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Tags row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _InfoChip(
                  icon: 'assets/icons/ic_wrench.svg',
                  label: item.category,
                ),
                SizedBox(width: 8.w),
                _InfoChip(
                  icon: 'assets/icons/ic_shield.svg',
                  label: item.warranty,
                ),
                SizedBox(width: 8.w),
                _InfoChip(
                  icon: 'assets/icons/ic_map_pin.svg',
                  label: item.location,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.colorWhite.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 10.w,
            height: 10.h,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.onboardingTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
