import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/messages/domain/models/message_model.dart';
import 'package:flutter/material.dart';

class MessagesRepository {
  factory MessagesRepository() {
    return _instance;
  }

  MessagesRepository._internal() {
    _initializeMockData();
  }
  // Singleton pattern for simplicity in this dummy repository
  static final MessagesRepository _instance = MessagesRepository._internal();

  List<LiveChatConversation> _conversations = [];
  final Map<String, List<ChatMessage>> _messages = {};

  void _initializeMockData() {
    _conversations = [
      const LiveChatConversation(
        name: 'AutoHub Support',
        lastMessage: 'Your pickup is confirmed for Apr 3.',
        time: '2h ago',
        initials: 'AS',
        avatarColor: AppColors.onboardingCyan,
        isOnline: true,
        chatRoomId: '1',
      ),
      const LiveChatConversation(
        name: 'PartSeller_Jay',
        lastMessage: 'Yes, the alternator is still available.',
        time: '1d ago',
        initials: 'PJ',
        avatarColor: AppColors.onboardingPurple,
        unreadCount: 1,
        chatRoomId: '2',
      ),
      const LiveChatConversation(
        name: 'QuickTow Inc.',
        lastMessage: "We'll arrive between 9-11am.",
        time: '3d ago',
        initials: 'QT',
        avatarColor: AppColors.onboardingGreen,
        chatRoomId: '3',
      ),
      const LiveChatConversation(
        name: 'BumperKing_HTX',
        lastMessage: r'I can do $290 for the bumper. Final offer',
        time: '5d ago',
        initials: 'BK',
        avatarColor: AppColors.warning,
        isOnline: true,
        chatRoomId: '4',
      ),
    ];

    _messages['1'] = [
      const ChatMessage(
        text: 'Let me look into that for you.',
        time: 'Just now',
        isSender: false,
      ),
      const ChatMessage(
        text: 'xaxx',
        time: 'Just now',
        isSender: true,
        isSent: false,
      ),
      const ChatMessage(
        text:
            "Your pickup is confirmed for Apr 3. We'll send a reminder the day before!",
        time: '2:30 PM',
        isSender: false,
      ),
      const ChatMessage(
        text:
            "Yes, someone needs to be present to hand over the keys and sign the release form. We'll call 30 minutes before arrival.",
        time: '11:15 AM',
        isSender: false,
      ),
      const ChatMessage(
        text: 'Great, thanks! Do I need to be present?',
        time: '11:02 AM',
        isSender: true,
      ),
      const ChatMessage(
        text:
            'Hello Mike! Your junk request has been reviewed and approved. The tow truck is scheduled for April 3rd between 9 AM and 12 PM.',
        time: '10:45 AM',
        isSender: false,
      ),
      const ChatMessage(
        text:
            'Hi! I submitted a junk request JNK-0412. When will the tow truck arrive?',
        time: '10:30 AM',
        isSender: true,
      ),
    ];

    _messages['2'] = [
      const ChatMessage(
        text: 'Yes, the alternator is still available.',
        time: 'Yesterday',
        isSender: false,
      ),
      const ChatMessage(
        text: 'Hello, is the alternator still available?',
        time: 'Yesterday',
        isSender: true,
      ),
    ];

    _messages['3'] = [
      const ChatMessage(
        text: "We'll arrive between 9-11am.",
        time: '3d ago',
        isSender: false,
      ),
      const ChatMessage(
        text: 'Do you have an ETA for the tow truck?',
        time: '3d ago',
        isSender: true,
      ),
    ];

    _messages['4'] = [
      const ChatMessage(
        text: r'I can do $290 for the bumper. Final offer',
        time: '5d ago',
        isSender: false,
      ),
      const ChatMessage(
        text: 'Can we negotiate the bumper pricing?',
        time: '5d ago',
        isSender: true,
      ),
    ];
  }

  List<LiveChatConversation> getConversations() {
    return _conversations.toList();
  }

  LiveChatConversation? getConversationById(String roomId) {
    try {
      return _conversations.firstWhere((c) => c.chatRoomId == roomId);
    } catch (e) {
      return null;
    }
  }

  List<ChatMessage> getMessages(String roomId) {
    return _messages[roomId]?.toList() ?? [];
  }

  void sendMessage(String roomId, ChatMessage message) {
    if (!_messages.containsKey(roomId)) {
      _messages[roomId] = [];
    }
    _messages[roomId]!.insert(0, message);

    // Also update the last message in conversations list
    final idx = _conversations.indexWhere((c) => c.chatRoomId == roomId);
    if (idx != -1) {
      final old = _conversations[idx];
      _conversations[idx] = LiveChatConversation(
        name: old.name,
        lastMessage: message.text,
        time: message.time,
        initials: old.initials,
        avatarColor: old.avatarColor,
        chatRoomId: old.chatRoomId,
        isOnline: old.isOnline,
        unreadCount: old.unreadCount,
      );
    }
  }

  void updateMessage(String roomId, int index, ChatMessage message) {
    if (_messages.containsKey(roomId) &&
        index >= 0 &&
        index < _messages[roomId]!.length) {
      _messages[roomId]![index] = message;
    }
  }

  void clearChat(String roomId) {
    _messages[roomId] = [];
  }

  void markAllAsRead() {
    _conversations = _conversations.map((convo) {
      return LiveChatConversation(
        name: convo.name,
        lastMessage: convo.lastMessage,
        time: convo.time,
        initials: convo.initials,
        avatarColor: convo.avatarColor,
        isOnline: convo.isOnline,
        unreadCount: 0,
        chatRoomId: convo.chatRoomId,
      );
    }).toList();
  }

  void deleteAllConversations() {
    _conversations = [];
    _messages.clear();
  }
}
