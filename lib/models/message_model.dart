enum MessageType {
  text,
  warning,
}

class MessageModel {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final MessageType type;

  MessageModel({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.type = MessageType.text,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      isUser: json['is_user'] ?? false,
      timestamp: DateTime.parse(json['timestamp']),
      type: _stringToMessageType(json['type'] ?? 'text'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_user': isUser,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString().split('.').last,
    };
  }

  static MessageType _stringToMessageType(String type) {
    switch (type) {
      case 'warning':
        return MessageType.warning;
      case 'text':
      default:
        return MessageType.text;
    }
  }
}
