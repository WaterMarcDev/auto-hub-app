import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_part_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeFeaturedParts extends StatelessWidget {
  const HomeFeaturedParts({super.key});

  static final _items = [
    const PartItemData(
      imagePath: 'assets/images/home_part_alternator.png',
      title: 'OEM Alternator',
      subtitle: 'Honda Civic (2016–2021)',
      price: '\$185',
      category: 'Electrical',
      warranty: '90 Days',
      location: 'Houston, TX',
      rating: 4.8,
      badge: PartBadgeType.featured,
      condition: PartCondition.excellent,
    ),
    const PartItemData(
      imagePath: 'assets/images/home_part_bumper.png',
      title: 'Front Bumper Assembly',
      subtitle: 'Ford F-150 (2018–2020)',
      price: '\$320',
      category: 'Body',
      warranty: '30 Days',
      location: 'Phoenix, AZ',
      rating: 4.6,
      badge: PartBadgeType.hotDeal,
      condition: PartCondition.good,
    ),
    const PartItemData(
      imagePath: 'assets/images/home_part_engine.png',
      title: '2.5L 4-Cylinder Engine',
      subtitle: 'Subaru Outback (2015–2019)',
      price: '\$1,650',
      category: 'Engine',
      warranty: '6 Months',
      location: 'Seattle, WA',
      rating: 4.8,
      badge: PartBadgeType.featured,
      condition: PartCondition.excellent,
    ),
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
              Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: AppColors.onboardingCyan.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/ic_trending_up.svg',
                      width: 13.w,
                      height: 13.h,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Featured Parts',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onboardingTextPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'View all',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onboardingCyan,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SvgPicture.asset(
                    'assets/icons/ic_chevron_right.svg',
                    width: 13.w,
                    height: 13.h,
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

        // Horizontal scroll cards
        SizedBox(
          height: 252.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20.w),
            itemCount: _items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.push('/part-details'),
                child: HomePartCardHorizontal(item: _items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
