import 'package:auto_hub_app/features/contact_support/domain/entities/chat_message.dart';
import 'package:auto_hub_app/features/contact_support/domain/entities/chat_room_info.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getMessages(String chatRoomId);
  Future<ChatRoomInfo> getRoomInfo(String chatRoomId);
  Future<void> sendMessage(String chatRoomId, ChatMessage message);
}
