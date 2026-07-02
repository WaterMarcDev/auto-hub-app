import 'package:flutter/material.dart';

class ChatRoomInfo {
  const ChatRoomInfo({
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
