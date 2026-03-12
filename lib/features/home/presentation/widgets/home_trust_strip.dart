import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTrustStrip extends StatelessWidget {
  const HomeTrustStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TrustItem(
            icon: 'assets/icons/ic_verified_yards.svg',
            label: 'Verified Yards',
          ),
          _TrustItem(
            icon: 'assets/icons/ic_fast_shipping.svg',
            label: 'Fast Shipping',
          ),
          _TrustItem(
            icon: 'assets/icons/ic_top_rated.svg',
            label: 'Top Rated',
          ),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  final String icon;
  final String label;

  const _TrustItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          width: 16.w,
          height: 16.h,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF484F58),
          ),
        ),
      ],
    );
  }
}
