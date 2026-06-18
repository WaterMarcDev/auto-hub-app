import 'package:flutter/material.dart';

@immutable
class LiveChatConversation {
  final String chatRoomId;
  final String name;
  final String lastMessage;
  final String time;
  final String initials;
  final Color avatarColor;
  final bool isOnline;
  final int unreadCount;

  const LiveChatConversation({
    required this.chatRoomId,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.initials,
    required this.avatarColor,
    this.isOnline = false,
    this.unreadCount = 0,
  });
}
