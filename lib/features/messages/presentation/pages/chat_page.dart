import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/messages/data/repositories/messages_repository.dart';
import 'package:auto_hub_app/features/messages/domain/models/message_model.dart';
import 'package:auto_hub_app/features/messages/presentation/widgets/chat_bubble.dart';
import 'package:auto_hub_app/features/messages/presentation/widgets/chat_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  late final MessagesRepository _repository;
  LiveChatConversation? _roomInfo;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _repository = MessagesRepository();
    _loadMessages();
  }

  void _loadMessages() {
    setState(() {
      _roomInfo = _repository.getConversationById(widget.chatRoomId);
      _messages = _repository.getMessages(widget.chatRoomId);
    });
  }

  void _sendMessage(String text) {
    final newMsg = ChatMessage(
      text: text,
      time: _formatCurrentTime(),
      isSender: true,
      isSent: false,
    );
    _repository.sendMessage(widget.chatRoomId, newMsg);
    _loadMessages();

    // Simulate reactive reply after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      setState(() {
        // Find message to mark sent
        final msgs = _repository.getMessages(widget.chatRoomId);
        final lastIdx = msgs.indexWhere((m) => m.isSender && !m.isSent);
        if (lastIdx != -1) {
          _repository.updateMessage(
            widget.chatRoomId,
            lastIdx,
            ChatMessage(
              text: msgs[lastIdx].text,
              time: msgs[lastIdx].time,
              isSender: true,
            ),
          );
        }

        // Auto reply with time evaluated AFTER mounted check
        _repository.sendMessage(
          widget.chatRoomId,
          ChatMessage(
            text:
                'Thanks for your message! An agent will look into this and reply soon.',
            time: _formatCurrentTime(),
            isSender: false,
          ),
        );

        _loadMessages();
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

  Future<void> _clearChat() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.onboardingSurfaceLight,
        title: Text(
          'Clear Chat?',
          style: AppTextStyles.headlineSmall.copyWith(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to clear this conversation? This action cannot be undone.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onboardingTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              _repository.clearChat(widget.chatRoomId);
              _loadMessages();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Chat messages cleared')),
                );
            },
            child: Text(
              'Clear',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_roomInfo == null) {
      return const Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, _roomInfo!),
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

  Widget _buildAppBar(BuildContext context, LiveChatConversation roomInfo) {
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

  Widget _buildAvatar(LiveChatConversation roomInfo) {
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
              style: AppTextStyles.bodyMedium.copyWith(
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
