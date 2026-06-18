import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/help_center/presentation/widgets/base_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class EmailSupportDialog extends StatelessWidget {
  const EmailSupportDialog({
    required this.onConfirm,
    super.key,
  });

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return BaseConfirmationDialog(
      icon: Icons.mail_outline_rounded,
      iconColor: AppColors.onboardingPurple,
      iconBgColor: AppColors.onboardingPurple.withValues(alpha: 0.1),
      iconBorderColor: AppColors.onboardingPurple.withValues(alpha: 0.15),
      title: 'Email Support?',
      description:
          "You'll be connected to our support team at support@autohub.express. We typically reply within 24 hours.",
      confirmText: 'Email Now',
      confirmButtonColor: AppColors.onboardingPurple,
      confirmButtonShadowColor:
          AppColors.onboardingPurple.withValues(alpha: 0.35),
      onConfirm: onConfirm,
    );
  }
}
