import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/contact_support/domain/entities/chat_message.dart';
import 'package:auto_hub_app/features/contact_support/domain/entities/chat_room_info.dart';
import 'package:auto_hub_app/features/contact_support/domain/repositories/chat_repository.dart';
import 'package:flutter/material.dart';

class MockChatRepository implements ChatRepository {
  @override
  Future<List<ChatMessage>> getMessages(String chatRoomId) async {
    if (chatRoomId == '1') {
      return [
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
    } else if (chatRoomId == '2') {
      return [
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
    } else if (chatRoomId == '3') {
      return [
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
    } else {
      return [
        const ChatMessage(
          text: 'I can do \$290 for the bumper. Final offer',
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
  }

  @override
  Future<ChatRoomInfo> getRoomInfo(String chatRoomId) async {
    switch (chatRoomId) {
      case '1':
        return const ChatRoomInfo(
          name: 'AutoHub Support',
          initials: 'AS',
          avatarColor: AppColors.onboardingCyan,
          isOnline: true,
        );
      case '2':
        return const ChatRoomInfo(
          name: 'PartSeller_Jay',
          initials: 'PJ',
          avatarColor: Color(0xFFA78BFA),
          isOnline: false,
        );
      case '3':
        return const ChatRoomInfo(
          name: 'QuickTow Inc.',
          initials: 'QT',
          avatarColor: Color(0xFF34D399),
          isOnline: false,
        );
      case '4':
        return const ChatRoomInfo(
          name: 'BumperKing_HTX',
          initials: 'BK',
          avatarColor: AppColors.warning,
          isOnline: true,
        );
      default:
        return const ChatRoomInfo(
          name: 'Chat Room',
          initials: 'C',
          avatarColor: Colors.grey,
          isOnline: false,
        );
    }
  }

  @override
  Future<void> sendMessage(String chatRoomId, ChatMessage message) async {
    // In a real app, this would persist the message.
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
