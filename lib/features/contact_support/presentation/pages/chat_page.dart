import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/chat_bubble.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/chat_input_bar.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/delete_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.chatRoomId,
    super.key,
  });

  final String chatRoomId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // We keep messages in reverse order (newest at index 0) for smooth ListView reversing
  List<_ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    if (widget.chatRoomId == '1') {
      _messages = [
        const _ChatMessage(
          text: 'Let me look into that for you.',
          time: 'Just now',
          isSender: false,
        ),
        const _ChatMessage(
          text: 'xaxx',
          time: 'Just now',
          isSender: true,
          isSent: false,
        ),
        const _ChatMessage(
          text:
              "Your pickup is confirmed for Apr 3. We'll send a reminder the day before!",
          time: '2:30 PM',
          isSender: false,
        ),
        const _ChatMessage(
          text:
              "Yes, someone needs to be present to hand over the keys and sign the release form. We'll call 30 minutes before arrival.",
          time: '11:15 AM',
          isSender: false,
        ),
        const _ChatMessage(
          text: 'Great, thanks! Do I need to be present?',
          time: '11:02 AM',
          isSender: true,
        ),
        const _ChatMessage(
          text:
              'Hello Mike! Your junk request has been reviewed and approved. The tow truck is scheduled for April 3rd between 9 AM and 12 PM.',
          time: '10:45 AM',
          isSender: false,
        ),
        const _ChatMessage(
          text:
              'Hi! I submitted a junk request JNK-0412. When will the tow truck arrive?',
          time: '10:30 AM',
          isSender: true,
        ),
      ];
    } else if (widget.chatRoomId == '2') {
      _messages = [
        const _ChatMessage(
          text: 'Yes, the alternator is still available.',
          time: 'Yesterday',
          isSender: false,
        ),
        const _ChatMessage(
          text: 'Hello, is the alternator still available?',
          time: 'Yesterday',
          isSender: true,
        ),
      ];
    } else if (widget.chatRoomId == '3') {
      _messages = [
        const _ChatMessage(
          text: "We'll arrive between 9-11am.",
          time: '3d ago',
          isSender: false,
        ),
        const _ChatMessage(
          text: 'Do you have an ETA for the tow truck?',
          time: '3d ago',
          isSender: true,
        ),
      ];
    } else {
      _messages = [
        const _ChatMessage(
          text: 'I can do \$290 for the bumper. Final offer',
          time: '5d ago',
          isSender: false,
        ),
        const _ChatMessage(
          text: 'Can we negotiate the bumper pricing?',
          time: '5d ago',
          isSender: true,
        ),
      ];
    }
  }

  _ChatRoomInfo _getRoomInfo() {
    switch (widget.chatRoomId) {
      case '1':
        return const _ChatRoomInfo(
          name: 'AutoHub Support',
          initials: 'AS',
          avatarColor: Color(0xFF0DA0CE),
          isOnline: true,
        );
      case '2':
        return const _ChatRoomInfo(
          name: 'PartSeller_Jay',
          initials: 'PJ',
          avatarColor: Color(0xFFA78BFA),
          isOnline: false,
        );
      case '3':
        return const _ChatRoomInfo(
          name: 'QuickTow Inc.',
          initials: 'QT',
          avatarColor: Color(0xFF34D399),
          isOnline: false,
        );
      case '4':
        return const _ChatRoomInfo(
          name: 'BumperKing_HTX',
          initials: 'BK',
          avatarColor: Color(0xFFFBBF24),
          isOnline: true,
        );
      default:
        return const _ChatRoomInfo(
          name: 'Chat Room',
          initials: 'C',
          avatarColor: Colors.grey,
          isOnline: false,
        );
    }
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.insert(
        0,
        _ChatMessage(
          text: text,
          time: _formatCurrentTime(),
          isSender: true,
          isSent: false,
        ),
      );
    });

    // Simulate reactive reply after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        // Mark previous message as sent/delivered (double checks)
        final lastIdx = _messages.indexWhere((m) => m.isSender && !m.isSent);
        if (lastIdx != -1) {
          _messages[lastIdx] = _ChatMessage(
            text: _messages[lastIdx].text,
            time: _messages[lastIdx].time,
            isSender: true,
            isSent: true,
          );
        }

        // Add auto reply
        _messages.insert(
          0,
          _ChatMessage(
            text:
                'Thanks for your message! An agent will look into this and reply soon.',
            time: _formatCurrentTime(),
            isSender: false,
          ),
        );
      });
    });
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $amPm';
  }

  void _clearChat() {
    showDialog<void>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        onConfirm: () {
          setState(() {
            _messages = [];
          });
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Chat messages cleared')),
            );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roomInfo = _getRoomInfo();

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, roomInfo),
            Expanded(
              child: _messages.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return ChatBubble(
                          message: msg.text,
                          time: msg.time,
                          isSender: msg.isSender,
                          isSent: msg.isSent,
                        );
                      },
                    ),
            ),
            ChatInputBar(onSend: _sendMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, _ChatRoomInfo roomInfo) {
    return Container(
      height: 70.h,
      decoration: const BoxDecoration(
        color: AppColors.onboardingBackground,
        border: Border(
          bottom: BorderSide(
            color: Color(0x12FFFFFF), // rgba(255,255,255,0.07)
            width: 0.8,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _buildAvatar(roomInfo),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  roomInfo.name,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  roomInfo.isOnline ? 'Online' : 'Offline',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: roomInfo.isOnline
                        ? AppColors.onboardingGreen
                        : AppColors.onboardingTextSecondary.withValues(
                            alpha: 0.6,
                          ),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _clearChat,
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.delete_outline_rounded,
                color: Colors.white.withValues(alpha: 0.8),
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(_ChatRoomInfo roomInfo) {
    return SizedBox(
      width: 38.r,
      height: 38.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: roomInfo.avatarColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            alignment: Alignment.center,
            child: Text(
              roomInfo.initials,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          if (roomInfo.isOnline)
            Positioned(
              right: -1.r,
              bottom: -1.r,
              child: Container(
                width: 12.r,
                height: 12.r,
                decoration: BoxDecoration(
                  color: AppColors.onboardingGreen,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.onboardingBackground,
                    width: 1.8.r,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            color: AppColors.onboardingTextSecondary.withValues(alpha: 0.15),
            size: 54.r,
          ),
          SizedBox(height: 12.h),
          Text(
            'Conversation Cleared',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Type a message to restart the chat.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.time,
    required this.isSender,
    this.isSent = true,
  });

  final String text;
  final String time;
  final bool isSender;
  final bool isSent;
}

class _ChatRoomInfo {
  const _ChatRoomInfo({
    required this.name,
    required this.initials,
    required this.avatarColor,
    required this.isOnline,
  });

  final String name;
  final String initials;
  final Color avatarColor;
  final bool isOnline;
}
