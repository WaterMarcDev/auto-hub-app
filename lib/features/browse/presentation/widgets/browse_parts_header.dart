import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowsePartsHeader extends StatelessWidget {
  const BrowsePartsHeader({
    super.key,
    required this.listedCount,
  });

  final int listedCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find what you need',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.colorGray,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Browse Parts',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.colorWhite,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.surfaceDarkVariant,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.accentTeal.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            '$listedCount Listed',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.accentTeal,
            ),
          ),
        ),
      ],
    );
  }
}
