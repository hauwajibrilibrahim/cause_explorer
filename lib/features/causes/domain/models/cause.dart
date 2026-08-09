import 'package:flutter/foundation.dart';

@immutable
class Cause {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String category;
  final String imageUrl;

  const Cause({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  Cause copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? category,
    String? imageUrl,
  }) {
    return Cause(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cause &&
        other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(id, userId, title, description, category, imageUrl);
  }

  @override
  String toString() {
    return 'Cause(id: $id, userId: $userId, title: "$title", category: "$category")';
  }
}
