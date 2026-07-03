import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/base_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class CallSupportDialog extends StatelessWidget {
  const CallSupportDialog({
    required this.onConfirm,
    super.key,
  });

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return BaseConfirmationDialog(
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.onboardingCyan,
      iconBgColor: AppColors.onboardingCyan.withValues(alpha: 0.1),
      iconBorderColor: AppColors.onboardingCyan.withValues(alpha: 0.15),
      title: 'Call Support?',
      description:
          "You'll be connected to our phone support team at +1 (800) 555-AUTO. Standard call rates may apply.",
      confirmText: 'Call Now',
      confirmButtonColor: AppColors.onboardingCyan,
      confirmButtonShadowColor: AppColors.onboardingCyan.withValues(alpha: 0.35),
      onConfirm: onConfirm,
    );
  }
}
