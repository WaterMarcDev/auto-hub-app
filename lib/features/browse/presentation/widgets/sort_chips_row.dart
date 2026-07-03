import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum SortType { newest, priceAsc, priceDesc, topRated }

class SortChipsRow extends StatelessWidget {
  const SortChipsRow({
    required this.selectedSort,
    required this.onChanged,
    super.key,
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
            label: 'Top Rated',
            icon: Icons.star_rounded,
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
    this.icon,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.info : AppColors.onboardingSurface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withValues(alpha: 0.07),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14.sp,
                color: isSelected ? Colors.white : AppColors.warning,
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
