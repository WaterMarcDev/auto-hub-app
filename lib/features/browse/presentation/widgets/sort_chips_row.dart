import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum SortType { newest, priceAsc, priceDesc, topRated }

class SortChipsRow extends StatelessWidget {
  const SortChipsRow({
    super.key,
    required this.selectedSort,
    required this.onChanged,
  });

  final SortType selectedSort;
  final ValueChanged<SortType> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _SortChip(
            label: 'Newest',
            isSelected: selectedSort == SortType.newest,
            onTap: () => onChanged(SortType.newest),
          ),
          SizedBox(width: 8.w),
          _SortChip(
            label: 'Price ↑',
            isSelected: selectedSort == SortType.priceAsc,
            onTap: () => onChanged(SortType.priceAsc),
          ),
          SizedBox(width: 8.w),
          _SortChip(
            label: 'Price ↓',
            isSelected: selectedSort == SortType.priceDesc,
            onTap: () => onChanged(SortType.priceDesc),
          ),
          SizedBox(width: 8.w),
          _SortChip(
            label: '⭐ Top Rated',
            isSelected: selectedSort == SortType.topRated,
            onTap: () => onChanged(SortType.topRated),
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00A8CC) : const Color(0xFF1A1F26),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0x12FFFFFF),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF8B929A),
          ),
        ),
      ),
    );
  }
}
