import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/payment_methods/presentations/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card management section listing cards with delete/set-default options.
class ManageCardsWidget extends StatelessWidget {
  const ManageCardsWidget({
    required this.cards,
    required this.onRemove,
    required this.onSetDefault,
    super.key,
  });

  final List<PaymentCard> cards;
  final ValueChanged<String> onRemove;
  final ValueChanged<String> onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.04),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'MANAGE CARDS',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5.w,
            ),
          ),
          SizedBox(height: 16.h),

          // Cards List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Divider(
                color: Colors.white.withValues(alpha: 0.08),
                height: 1.h,
              ),
            ),
            itemBuilder: (context, index) {
              final card = cards[index];
              final isVisa = card.brand.toLowerCase() == 'visa';

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side: Card Icon Container
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: AppColors.onboardingSurfaceLight,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.credit_card_rounded,
                      color: isVisa ? Colors.blue.shade300 : Colors.orange.shade300,
                      size: 20.w,
                    ),
                  ),
                  SizedBox(width: 14.w),

                  // Right Side: Details & Actions
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Brand & Masked Number
                        Text(
                          '${card.brand} •••• ${card.last4}',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.onboardingTextPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 3.h),

                        // Card Expiry info
                        Text(
                          'Expires ${card.expiry}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onboardingTextSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Action Buttons Row
                        Row(
                          children: [
                            if (!card.isDefault) ...[
                              _buildActionButton(
                                label: 'Set Default',
                                icon: Icons.check_circle_outline_rounded,
                                color: AppColors.onboardingGreen,
                                backgroundColor: AppColors.onboardingGreen
                                    .withValues(alpha: 0.08),
                                borderColor: AppColors.onboardingGreen
                                    .withValues(alpha: 0.15),
                                onTap: () => onSetDefault(card.id),
                              ),
                              SizedBox(width: 10.w),
                            ],
                            _buildActionButton(
                              label: 'Remove',
                              icon: Icons.delete_outline_rounded,
                              color: AppColors.error,
                              backgroundColor:
                                  AppColors.error.withValues(alpha: 0.08),
                              borderColor:
                                  AppColors.error.withValues(alpha: 0.15),
                              onTap: () => onRemove(card.id),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Builds a customized tactile action button (Set Default / Remove).
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor, width: 1.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 13.w),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: color,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
