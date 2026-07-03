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
                color: const Color(0xFF8B929A),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Browse Parts',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F26),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFF00A8CC).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            '$listedCount Listed',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF00A8CC),
            ),
          ),
        ),
      ],
    );
  }
}
