import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeVinLookup extends StatelessWidget {
  const HomeVinLookup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: const Color(0xFF0DA0CE).withValues(alpha: 0.2),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0DA0CE).withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment(-0.81, -1.0),
            end: Alignment(0.81, 1.0),
            colors: [Color(0xFF0A1220), Color(0xFF08101A)],
          ),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0DA0CE).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/ic_scan_line.svg',
                    width: 14.w,
                    height: 14.h,
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VIN Parts Lookup',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0F6FC),
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Find exact-fit parts for your vehicle',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8B929A),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // VIN input
            Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1C2330),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0x14FFFFFF),
                  width: 0.8,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter 17-digit VIN...',
                style: GoogleFonts.spaceMono(
                  fontSize: 13.sp,
                  color: const Color(0x80F0F6FC),
                  letterSpacing: 1.0,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Bottom row: character count + find button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0/17 characters',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF484F58),
                  ),
                ),
                Opacity(
                  opacity: 0.7,
                  child: Container(
                    height: 36.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.06),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_search.svg',
                          width: 12.w,
                          height: 12.h,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Find Parts',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF484F58),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
