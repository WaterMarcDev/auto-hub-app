import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:auto_hub_app/features/home/presentation/widgets/home_part_card.dart';

class HomeRecentListings extends StatelessWidget {
  const HomeRecentListings({super.key});

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
      imagePath: 'assets/images/home_part_transmission.png',
      title: '6-Speed Automatic Transmission',
      subtitle: 'Chevrolet Malibu (2016–2019)',
      price: '\$750',
      category: 'Transmission',
      warranty: '6 Months',
      location: 'Chicago, IL',
      rating: 4.9,
      badge: PartBadgeType.certified,
      condition: PartCondition.excellent,
    ),
    const PartItemData(
      imagePath: 'assets/images/home_part_headlight.png',
      title: 'LED Headlight Assembly — Left',
      subtitle: 'Toyota Camry (2018–2022)',
      price: '\$275',
      category: 'Electrical',
      warranty: '90 Days',
      location: 'Los Angeles, CA',
      rating: 4.7,
      badge: PartBadgeType.none,
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
                      color: const Color(0xFFA78BFA).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/ic_sparkles.svg',
                      width: 13.w,
                      height: 13.h,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Recent Listings',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFF0F6FC),
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
                      color: const Color(0xFF0DA0CE),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SvgPicture.asset(
                    'assets/icons/ic_chevron_right.svg',
                    width: 13.w,
                    height: 13.h,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF0DA0CE),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Vertical list of cards
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: _items.length,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            return HomePartCardVertical(item: _items[index]);
          },
        ),
      ],
    );
  }
}
