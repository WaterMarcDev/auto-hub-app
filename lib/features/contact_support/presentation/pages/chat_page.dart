import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/contact_support/data/repositories/mock_chat_repository.dart';
import 'package:auto_hub_app/features/contact_support/domain/entities/chat_message.dart';
import 'package:auto_hub_app/features/contact_support/domain/entities/chat_room_info.dart';
import 'package:auto_hub_app/features/contact_support/domain/repositories/chat_repository.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/chat_bubble.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/chat_input_bar.dart';
import 'package:auto_hub_app/features/contact_support/presentation/widgets/delete_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveChatPage extends StatefulWidget {
  const LiveChatPage({
    required this.chatRoomId,
    super.key,
  });

  final String chatRoomId;

  @override
  State<LiveChatPage> createState() => _LiveChatPageState();
}

class _LiveChatPageState extends State<LiveChatPage> {
  final ChatRepository _chatRepository = MockChatRepository();
  List<ChatMessage> _messages = [];
  ChatRoomInfo? _roomInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final roomInfo = await _chatRepository.getRoomInfo(widget.chatRoomId);
    final messages = await _chatRepository.getMessages(widget.chatRoomId);
    if (mounted) {
      setState(() {
        _roomInfo = roomInfo;
        _messages = messages;
        _isLoading = false;
      });
    }
  }
  void _sendMessage(String text) async {
    final newMessage = ChatMessage(
      text: text,
      time: _formatCurrentTime(),
      isSender: true,
      isSent: false,
    );
    setState(() {
      _messages.insert(0, newMessage);
    });

    await _chatRepository.sendMessage(widget.chatRoomId, newMessage);

    // Simulate reactive reply after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        // Mark previous message as sent/delivered (double checks)
        final lastIdx = _messages.indexWhere((m) => m.isSender && !m.isSent);
        if (lastIdx != -1) {
          _messages[lastIdx] = ChatMessage(
            text: _messages[lastIdx].text,
            time: _messages[lastIdx].time,
            isSender: true,
            isSent: true,
          );
        }

        // Add auto reply
        _messages.insert(
          0,
          ChatMessage(
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
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final roomInfo = _roomInfo!;

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

  Widget _buildAppBar(BuildContext context, ChatRoomInfo roomInfo) {
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
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
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

  Widget _buildAvatar(ChatRoomInfo roomInfo) {
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
