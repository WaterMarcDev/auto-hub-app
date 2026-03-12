import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:auto_hub_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_category_section.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_featured_parts.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_hero_banner.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_junk_car_banner.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_recent_listings.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_stats_row.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_trust_strip.dart';
import 'package:auto_hub_app/features/home/presentation/widgets/home_vin_lookup.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Force dark status bar icons on the dark background
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const HomeAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      // Search bar
                      const HomeSearchBar(),

                      SizedBox(height: 16.h),

                      // Hero banner
                      const HomeHeroBanner(),

                      SizedBox(height: 22.h),

                      // Stats row
                      const HomeStatsRow(),

                      SizedBox(height: 20.h),

                      // Browse by Category
                      const HomeCategorySection(),

                      SizedBox(height: 15.h),

                      // VIN Parts Lookup
                      const HomeVinLookup(),

                      SizedBox(height: 28.h),

                      // Featured Parts
                      const HomeFeaturedParts(),

                      SizedBox(height: 24.h),

                      // Recent Listings
                      const HomeRecentListings(),

                      SizedBox(height: 20.h),

                      // Junk Your Car CTA
                      const HomeJunkCarBanner(),

                      SizedBox(height: 24.h),

                      // Trust strip
                      const HomeTrustStrip(),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
