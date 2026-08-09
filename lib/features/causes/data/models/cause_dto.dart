import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_categories.dart';
import '../../domain/models/cause.dart';

// Data Transfer Object for Cause
class CauseDto {
  final int id;
  final int userId;
  final String title;
  final String body;

  const CauseDto({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory CauseDto.fromJson(Map<String, dynamic> json) {
    return CauseDto(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  /// Convert DTO to Domain Entity, mapping titles, descriptions, formulas, & image URLs
  Cause toDomain() {
    return Cause(
      id: id,
      userId: userId,
      title: _capitalize(title),
      description: body,
      category: AppCategories.deriveCategoryFromUserId(userId),
      imageUrl: ApiConstants.getImageUrl(id),
    );
  }

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
