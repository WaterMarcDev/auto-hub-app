import 'package:flutter/material.dart';

@immutable
class LiveChatConversation {
  const LiveChatConversation({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.initials,
    required this.avatarColor,
    required this.chatRoomId,
    this.isOnline = false,
    this.unreadCount = 0,
  });

  final String name;
  final String lastMessage;
  final String time;
  final String initials;
  final Color avatarColor;
  final String chatRoomId;
  final bool isOnline;
  final int unreadCount;
}

@immutable
class ChatMessage {
  const ChatMessage({
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
