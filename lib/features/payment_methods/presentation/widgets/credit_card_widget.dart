import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/payment_methods/domain/entities/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A premium credit card widget with interactive micro-animations,
/// glassmorphism, background abstract patterns, and a custom gold chip.
class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget({
    required this.card,
    super.key,
    this.onTap,
  });

  final PaymentCard card;
  final VoidCallback? onTap;

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final brandLower = widget.card.brand.toLowerCase();
    final isVisa = brandLower == 'visa';
    final isMastercard = brandLower == 'mastercard';
    final isAmex = brandLower == 'amex';

    // Gradients matching the specified brand themes.
    LinearGradient cardGradient;
    if (isVisa) {
      cardGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primaryLight,
          AppColors.cardVisaNavy,
          AppColors.primaryDark, // Dark space blue
        ],
        stops: [0.0, 0.6, 1.0],
      );
    } else if (isAmex) {
      cardGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.cardAmexLight,
          AppColors.cardAmexBlue,
          AppColors.cardAmexDark,
        ],
        stops: [0.0, 0.5, 1.0],
      );
    } else if (isMastercard) {
      cardGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.secondary, // Vibrant coral
          AppColors.secondaryDark,
          AppColors.cardMastercardCrimson,
        ],
        stops: [0.0, 0.5, 1.0],
      );
    } else {
      cardGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.cardDefaultLight,
          AppColors.cardDefaultMid,
          AppColors.cardDefaultDark,
        ],
        stops: [0.0, 0.5, 1.0],
      );
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: Container(
          width: double.infinity,
          height: 200.h,
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: cardGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 16.r,
                offset: Offset(0, 8.h),
              ),
              if (widget.card.isDefault)
                BoxShadow(
                  color: (isVisa ? Colors.blue : Colors.orange).withValues(
                    alpha: 0.15,
                  ),
                  blurRadius: 24.r,
                  spreadRadius: 2.r,
                ),
            ],
          ),
          child: Stack(
            children: [
              // ── Background Abstract Shapes (Premium styling) ────────────
              Positioned(
                right: -40.w,
                top: -40.h,
                child: Container(
                  width: 220.w,
                  height: 220.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.colorWhite.withValues(alpha: 0.08),
                        AppColors.colorWhite.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -20.w,
                bottom: -60.h,
                child: Container(
                  width: 180.w,
                  height: 180.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.colorWhite.withValues(alpha: 0.06),
                        AppColors.colorWhite.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),

              // Diagonal Sleek Gloss Overlay (Metallic finish)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.colorWhite.withValues(alpha: 0.15),
                          AppColors.colorWhite.withValues(alpha: 0.02),
                          AppColors.colorWhite.withValues(alpha: 0.0),
                          AppColors.colorWhite.withValues(alpha: 0.05),
                        ],
                        stops: const [0.0, 0.3, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Card Foreground Content ───────────────────────────────
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Brand & Default Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.card.brand.toUpperCase(),
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.w,
                          ),
                        ),
                        if (widget.card.isDefault)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.colorWhite.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: AppColors.colorWhite.withValues(
                                  alpha: 0.25,
                                ),
                                width: 1.w,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  AppIcons.checkCircle,
                                  color: AppColors.onboardingGreen,
                                  size: 11.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'DEFAULT',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.colorWhite,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),

                    // Golden EMV Chip
                    _buildGoldChip(),

                    const Spacer(),

                    // Card Number
                    Text(
                      widget.card.maskedNumber,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.colorWhite,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.w,
                        fontSize: 20.sp,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            offset: Offset(0, 1.h),
                            blurRadius: 3.r,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // Bottom Row: Holder Name & Expiry
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CARD HOLDER',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.colorWhite.withValues(
                                  alpha: 0.5,
                                ),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8.w,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              widget.card.cardHolder,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'EXPIRES',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.colorWhite.withValues(
                                  alpha: 0.5,
                                ),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8.w,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              widget.card.expiry,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a detailed vector golden EMV smart chip container.
  Widget _buildGoldChip() {
    return Container(
      width: 38.w,
      height: 28.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.chipGoldLight,
            AppColors.chipGoldMetallic,
            AppColors.chipGoldDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 2.r,
            offset: Offset(0, 1.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Inner grid micro-lines to make it look realistic.
          Positioned(
            left: 10.w,
            top: 0,
            bottom: 0,
            child: Container(
              width: 1.w,
              color: AppColors.chipGoldLine.withValues(alpha: 0.5),
            ),
          ),
          Positioned(
            right: 10.w,
            top: 0,
            bottom: 0,
            child: Container(
              width: 1.w,
              color: AppColors.chipGoldLine.withValues(alpha: 0.5),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 9.h,
            child: Container(
              height: 1.h,
              color: AppColors.chipGoldLine.withValues(alpha: 0.5),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 9.h,
            child: Container(
              height: 1.h,
              color: AppColors.chipGoldLine.withValues(alpha: 0.5),
            ),
          ),
          // Center core element
          Center(
            child: Container(
              width: 10.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.chipGoldCenter,
                borderRadius: BorderRadius.circular(2.r),
                border: Border.all(
                  color: AppColors.chipGoldLine.withValues(alpha: 0.4),
                  width: 0.5.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
