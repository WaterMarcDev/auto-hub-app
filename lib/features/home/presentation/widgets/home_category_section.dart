import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  static const _categories = [
    _Category(emoji: '🔧', name: 'Engine', count: '1,284'),
    _Category(emoji: '🚗', name: 'Body', count: '876'),
    _Category(emoji: '⚡', name: 'Electrical', count: '543'),
    _Category(emoji: '🪑', name: 'Interior', count: '429'),
    _Category(emoji: '🔩', name: 'Suspension', count: '318'),
    _Category(emoji: '❄️', name: 'Cooling', count: '207'),
    _Category(emoji: '🛑', name: 'Brakes', count: '394'),
    _Category(emoji: '⚙️', name: 'Transmission', count: '162'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Browse by Category',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onboardingTextPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See all',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onboardingCyan,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SvgPicture.asset(
                    'assets/icons/ic_chevron_right.svg',
                    width: 12.w,
                    height: 12.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.onboardingCyan,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Horizontal scrollable categories
        SizedBox(
          height: 106.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20.w),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              return _CategoryCard(category: _categories[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _Category category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.07),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category.emoji,
            style: TextStyle(fontSize: 24.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            category.name,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.onboardingTextPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            category.count,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Category {
  final String emoji;
  final String name;
  final String count;

  const _Category({
    required this.emoji,
    required this.name,
    required this.count,
  });
}
