import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0x14FFFFFF),
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
        child: Row(
          children: [
            SizedBox(width: 14.w),
            const Icon(
              AppIcons.search,
              color: Color(0x80F0F6FC),
              size: 16,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Search part name, make, model...',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0x80F0F6FC),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            // Search button
            Container(
              width: 68.w,
              height: 30.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.6, -1.0),
                  end: Alignment(0.6, 1.0),
                  colors: [Color(0xFF0DA0CE), Color(0xFF0B8FB5)],
                ),
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0DA0CE).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'Search',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 4.w),
          ],
        ),
      ),
    );
  }
}
