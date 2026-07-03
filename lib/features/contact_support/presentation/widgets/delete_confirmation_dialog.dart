import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/base_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({
    required this.onConfirm,
    super.key,
  });

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return BaseConfirmationDialog(
      icon: Icons.warning_amber_rounded,
      iconColor: AppColors.error,
      iconBgColor: AppColors.error.withValues(alpha: 0.1),
      title: 'Delete Conversation?',
      description:
          'All messages in this conversation will be permanently deleted. This cannot be undone.',
      confirmText: 'Delete',
      confirmButtonColor: AppColors.error,
      onConfirm: onConfirm,
    );
  }
}
