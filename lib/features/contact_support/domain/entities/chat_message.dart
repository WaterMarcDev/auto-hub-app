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
