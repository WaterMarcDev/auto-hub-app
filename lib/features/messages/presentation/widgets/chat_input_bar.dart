import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    required this.onSend,
    super.key,
  });

  final ValueChanged<String> onSend;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_textListener);
  }

  void _textListener() {
    final isEmpty = _controller.text.trim().isEmpty;
    if (isEmpty != _isTextEmpty) {
      setState(() {
        _isTextEmpty = isEmpty;
      });
    }
  }

  @override
  void dispose() {
    _controller..removeListener(_textListener)
    ..dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final paddingBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        (paddingBottom > 0 ? paddingBottom : 12.h) + bottomInset,
      ),
      decoration: BoxDecoration(
        color: AppColors.onboardingBackground,
        border: Border(
          top: BorderSide(
            color: const Color(0x12FFFFFF), // rgba(255,255,255,0.07)
            width: 0.8.w,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Image upload coming soon')),
                );
            },
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: AppColors.onboardingSurface,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                AppIcons.imageOutlined,
                color: Colors.white.withValues(alpha: 0.7),
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: _controller,
              cursorColor: AppColors.onboardingCyan,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onboardingTextSecondary.withValues(
                    alpha: 0.4,
                  ),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: AppColors.onboardingSurface,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 1.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: const BorderSide(
                    color: AppColors.onboardingCyan,
                    width: 1.0,
                  ),
                ),
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: _isTextEmpty ? null : _handleSend,
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: _isTextEmpty
                    ? AppColors.onboardingSurface
                    : AppColors.onboardingCyan,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: _isTextEmpty ? 0.08 : 0.15,
                  ),
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                AppIcons.send,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
