import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/messages/data/repositories/messages_repository.dart';
import 'package:auto_hub_app/features/messages/domain/models/message_model.dart';
import 'package:auto_hub_app/features/messages/presentation/widgets/conversation_tile.dart';
import 'package:auto_hub_app/features/messages/presentation/widgets/message_options_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LiveChatPage extends StatefulWidget {
  const LiveChatPage({super.key});

  @override
  State<LiveChatPage> createState() => _LiveChatPageState();
}

class _LiveChatPageState extends State<LiveChatPage> {
  late final MessagesRepository _repository;
  List<LiveChatConversation> _conversations = [];

  @override
  void initState() {
    super.initState();
    _repository = MessagesRepository();
    _loadConversations();
  }

  void _loadConversations() {
    setState(() {
      _conversations = _repository.getConversations();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh conversations in case they changed in another screen
    _loadConversations();
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _conversations.fold<int>(
      0,
      (sum, item) => sum + item.unreadCount,
    );

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            SizedBox(height: 18.h),
            if (unreadCount > 0) ...[
              _buildUnreadSubheader(unreadCount),
              SizedBox(height: 24.h),
            ] else ...[
              SizedBox(height: 12.h),
            ],
            Expanded(
              child: _conversations.isEmpty
                  ? _buildEmptyState()
                  : _buildConversationsSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                  width: 40.r,
                  height: 40.r,
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
                    AppIcons.chevronLeft,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Text(
                'Messages',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.onboardingTextPrimary,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog<void>(
                context: context,
                barrierColor: Colors.black.withValues(alpha: 0.6),
                builder: (context) => MessageOptionsOverlay(
                  onMarkAllAsRead: () {
                    _repository.markAllAsRead();
                    _loadConversations();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('All messages marked as read'),
                        ),
                      );
                  },
                  onDeleteAll: () {
                    _repository.deleteAllConversations();
                    _loadConversations();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('All conversations deleted'),
                        ),
                      );
                  },
                ),
              );
            },
            child: Container(
              width: 40.r,
              height: 40.r,
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
                AppIcons.moreVert,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnreadSubheader(int count) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: const BoxDecoration(
              color: AppColors.onboardingCyan,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '$count unread message${count > 1 ? 's' : ''}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingCyan,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONVERSATIONS',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.onboardingSurfaceLight,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.07),
                  width: 0.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _conversations.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white.withValues(alpha: 0.05),
                  height: 1.h,
                ),
                itemBuilder: (context, index) {
                  final convo = _conversations[index];
                  return ConversationTile(
                    conversation: convo,
                    onTap: () {
                      context.push('/chat?chatRoomId=${convo.chatRoomId}');
                    },
                  );
                },
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
          SizedBox(height: 80.h),
          Icon(
            AppIcons.chatBubble,
            color: AppColors.onboardingTextSecondary.withValues(alpha: 0.15),
            size: 64.r,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Messages',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your conversations will show up here.',
            textAlign: TextAlign.center,
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
