import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyPartsView extends StatelessWidget {
  const EmptyPartsView({
    super.key,
    required this.onClearFilters,
  });

  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60.h),
        Container(
          width: 88.r,
          height: 88.r,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F26),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: const Color(0x12FFFFFF),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.search,
            size: 40.r,
            color: const Color(0xFF8B929A),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'No parts found',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Try adjusting your search or filters',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8B929A),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        GestureDetector(
          onTap: onClearFilters,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF00A8CC),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00A8CC).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Clear Filters',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 60.h),
      ],
    );
  }
}
