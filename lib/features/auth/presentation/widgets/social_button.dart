import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {

  const SocialButton({
    required this.text,
    required this.iconPath,
    required this.backgroundColor,
    required this.textColor,
    required this.shadowColor,
    required this.onPressed,
    super.key,
    this.borderColor,
  });
  final String text;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;
  final Color shadowColor;
  final VoidCallback onPressed;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.25,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.41),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 0.82)
            : null,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12.3,
            offset: const Offset(0, 2.05),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.41),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 20.5,
                height: 20.5,
              ),
              const SizedBox(width: 12.3),
              Text(
                text,
                style: AppTextStyles.labelLarge.copyWith(
                  color: textColor,
                  fontSize: 14.36,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
