import 'package:flutter/foundation.dart';

/// メッセージの送信者
enum MessageRole {
  user,
  assistant,
  system,
}

/// チャットメッセージモデル
@immutable
class ChatMessage {
  final String id;

  final MessageRole role;

  final String text;

  final DateTime createdAt;

  /// AIが考え中かどうか
  final bool isLoading;

  /// エラー表示用
  final bool isError;

  /// 添付画像のパス（将来OCR対応）
  final String? imagePath;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    required this.createdAt,
    this.isLoading = false,
    this.isError = false,
    this.imagePath,
  });

  bool get isUser => role == MessageRole.user;

  bool get isAssistant => role == MessageRole.assistant;

  bool get isSystem => role == MessageRole.system;

  ChatMessage copyWith({
    String? id,
    MessageRole? role,
    String? text,
    DateTime? createdAt,
    bool? isLoading,
    bool? isError,
    String? imagePath,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role.name,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'isLoading': isLoading,
      'isError': isError,
      'imagePath': imagePath,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      role: MessageRole.values.firstWhere(
        (e) => e.name == map['role'],
      ),
      text: map['text'] as String,
      createdAt: DateTime.parse(
        map['createdAt'] as String,
      ),
      isLoading: map['isLoading'] ?? false,
      isError: map['isError'] ?? false,
      imagePath: map['imagePath'],
    );
  }

  @override
  String toString() {
    return 'ChatMessage('
        'id: $id, '
        'role: ${role.name}, '
        'text: $text'
        ')';
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
