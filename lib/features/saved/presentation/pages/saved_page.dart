import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({required this.onBrowseTap, super.key});

  final VoidCallback onBrowseTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0D1117),
                    Color(0xFF0B1016),
                    Color(0xFF070E17),
                  ],
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
          ),

          // Ambient glow behind the empty-state icon cluster
          Positioned(
            top: 70.h,
            left: 74.w,
            child: Container(
              width: 212.w,
              height: 212.h,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0x2A0DA0CE), Color(0x000DA0CE)],
                  stops: [0, 1],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -38.h,
            left: 0,
            right: 0,
            child: Container(
              height: 130.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x000DA0CE),
                    Color(0x1F0DA0CE),
                    Color(0x000DA0CE),
                  ],
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  height: 76.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF161B22),
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0x0FFFFFFF),
                        width: 0.8,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0.8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My wishlist',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF484F58),
                        ),
                      ),
                      Text(
                        'Saved Parts',
                        style: GoogleFonts.inter(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFF0F6FC),
                          height: 1.5,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 384.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 70.h,
                        left: 124.w,
                        child: SizedBox(
                          width: 112.w,
                          height: 112.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 112.w,
                                height: 112.h,
                                decoration: BoxDecoration(
                                  color: const Color(0x0F0DA0CE),
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color: const Color(0x1F0DA0CE),
                                    width: 0.8,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x140DA0CE),
                                      blurRadius: 40,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/icons/ic_saved_heart_empty.svg',
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              ),
                              Positioned(
                                right: -8.w,
                                top: -8.h,
                                child: Container(
                                  width: 32.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0x0D0DA0CE),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0x1A0DA0CE),
                                      width: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -8.w,
                                bottom: -8.h,
                                child: Container(
                                  width: 20.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0x0A0DA0CE),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0x140DA0CE),
                                      width: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 206.2.h,
                        left: 0,
                        right: 0,
                        child: Text(
                          'No saved parts yet',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFF0F6FC),
                            height: 1.5,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 247.2.h,
                        left: 62.w,
                        right: 62.w,
                        child: Text(
                          'Tap the ♥ on any part listing to\nsave it to your wishlist',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8B929A),
                            height: 1.7,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 316.2.h,
                        left: 83.w,
                        child: GestureDetector(
                          onTap: onBrowseTap,
                          child: Container(
                            width: 194.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              gradient: const LinearGradient(
                                begin: Alignment(-0.62, -1.0),
                                end: Alignment(0.62, 1.0),
                                colors: [
                                  Color(0xFF0DA0CE),
                                  Color(0xFF0B8FB5),
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x660DA0CE),
                                  blurRadius: 24,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_saved_wrench.svg',
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Browse Parts',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                SvgPicture.asset(
                                  'assets/icons/ic_saved_arrow_right.svg',
                                  width: 16.w,
                                  height: 16.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
