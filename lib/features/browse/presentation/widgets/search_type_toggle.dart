import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum SearchType { part, vin }

class SearchTypeToggle extends StatelessWidget {
  const SearchTypeToggle({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final SearchType selectedType;
  final ValueChanged<SearchType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFF131922),
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Stack(
        children: [
          // Sliding active pill background
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: selectedType == SearchType.part
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0DA0CE),
                  borderRadius: BorderRadius.circular(22.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0DA0CE).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Interactive tabs
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(SearchType.part),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_search.svg',
                          width: 16.w,
                          height: 16.h,
                          colorFilter: ColorFilter.mode(
                            selectedType == SearchType.part
                                ? Colors.white
                                : const Color(0xFF4C5562),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Part Search',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: selectedType == SearchType.part
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: selectedType == SearchType.part
                                ? Colors.white
                                : const Color(0xFF4C5562),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(SearchType.vin),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_scan_line.svg',
                          width: 16.w,
                          height: 16.h,
                          colorFilter: ColorFilter.mode(
                            selectedType == SearchType.vin
                                ? Colors.white
                                : const Color(0xFF4C5562),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'VIN Lookup',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: selectedType == SearchType.vin
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: selectedType == SearchType.vin
                                ? Colors.white
                                : const Color(0xFF4C5562),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
