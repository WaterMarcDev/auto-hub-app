import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/browse/domain/models/product_part_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.part,
    this.onTap,
    this.onFavoriteTap,
    super.key,
  });

  final ProductPartItem part;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    // Condition color helpers
    Color conditionColor;
    switch (part.condition.toLowerCase()) {
      case 'excellent':
        conditionColor = AppColors.success;
      case 'good':
        conditionColor = AppColors.info;
      case 'fair':
        conditionColor = AppColors.warning;
      default:
        conditionColor = AppColors.error;
    }

    // Tag styling helper
    var tagBg = Colors.transparent;
    var tagText = Colors.white;
    if (part.tag != null) {
      switch (part.tag!.toLowerCase()) {
        case 'featured':
          tagBg = AppColors.info.withValues(alpha: 0.15);
          tagText = AppColors.info;
        case 'new':
          tagBg = AppColors.onboardingPurple.withValues(alpha: 0.15);
          tagText = AppColors.onboardingPurple;
        case 'certified':
          tagBg = AppColors.success.withValues(alpha: 0.15);
          tagText = AppColors.success;
        default: // Hot Deal, etc.
          tagBg = AppColors.secondaryDark.withValues(alpha: 0.15);
          tagText = AppColors.secondaryDark;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F26),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0x12FFFFFF),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header
            SizedBox(
              height: 160.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    part.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF12161A),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: Color(0xFF8B929A),
                          size: 40,
                        ),
                      );
                    },
                  ),
                  // Dark Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // Favorite Button (Top Right)
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1117).withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                            width: 0.8,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/ic_heart.svg',
                          width: 14.w,
                          height: 14.h,
                          colorFilter: ColorFilter.mode(
                            part.isFavorite
                                ? AppColors.error
                                : Colors.white,
                            BlendMode.srcIn,
                          ),
                          placeholderBuilder: (context) => const Icon(
                            Icons.error_outline,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Tag Badges (Top Left)
                  if (part.tag != null)
                    Positioned(
                      top: 12.h,
                      left: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: tagBg,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: tagText.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          part.tag!,
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: tagText,
                          ),
                        ),
                      ),
                    ),
                  // Price and Condition overlay at bottom of image
                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: 12.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${part.price.toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: conditionColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: conditionColor.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            part.condition,
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: conditionColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Details Section
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          part.title,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        height: 24.h,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_star.svg',
                              width: 11.w,
                              height: 11.h,
                              placeholderBuilder: (context) => const Icon(
                                Icons.error_outline,
                                size: 11,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              part.rating.toStringAsFixed(1),
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFBBF24),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_tag.svg',
                        width: 12.w,
                        height: 12.h,
                        placeholderBuilder: (context) => const Icon(
                          Icons.error_outline,
                          size: 12,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${part.make} ${part.model} (${part.yearRange})',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8B929A),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _DetailChip(
                        iconPath: 'assets/icons/ic_wrench.svg',
                        label: part.category,
                      ),
                      _DetailChip(
                        iconPath: 'assets/icons/ic_shield.svg',
                        label: part.warranty,
                      ),
                      _DetailChip(
                        iconPath: 'assets/icons/ic_map_pin.svg',
                        label: part.location,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.iconPath,
    required this.label,
  });

  final String iconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 10.w,
            height: 10.h,
            colorFilter: const ColorFilter.mode(
              AppColors.textSecondary,
              BlendMode.srcIn,
            ),
            placeholderBuilder: (context) => const Icon(
              Icons.error_outline,
              size: 10,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8B929A),
            ),
          ),
        ],
      ),
    );
  }
}
