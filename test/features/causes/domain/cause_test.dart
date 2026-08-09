import 'package:cause_explorer/core/constants/app_categories.dart';
import 'package:cause_explorer/features/causes/data/models/cause_dto.dart';
import 'package:cause_explorer/features/causes/domain/models/cause.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Category Derivation Formula Tests', () {
    test('userId 1 maps to Health (index 0)', () {
      expect(AppCategories.deriveCategoryFromUserId(1), 'Health');
    });

    test('userId 2 maps to Education (index 1)', () {
      expect(AppCategories.deriveCategoryFromUserId(2), 'Education');
    });

    test('userId 3 maps to Emergency (index 2)', () {
      expect(AppCategories.deriveCategoryFromUserId(3), 'Emergency');
    });

    test('userId 4 maps to Environment (index 3)', () {
      expect(AppCategories.deriveCategoryFromUserId(4), 'Environment');
    });

    test('userId 5 maps to Empowerment (index 4)', () {
      expect(AppCategories.deriveCategoryFromUserId(5), 'Empowerment');
    });

    test('userId 6 wraps around to Health (index 0)', () {
      expect(AppCategories.deriveCategoryFromUserId(6), 'Health');
    });
  });

  group('CauseDto toDomain Mapping Tests', () {
    test('correctly maps raw JSON to Cause entity', () {
      const dto = CauseDto(
        id: 42,
        userId: 3,
        title: 'clean water initiative',
        body: 'Providing clean water to underserved villages.',
      );

      final cause = dto.toDomain();

      expect(cause.id, 42);
      expect(cause.userId, 3);
      expect(cause.title, 'Clean water initiative');
      expect(cause.category, 'Emergency');
      expect(cause.imageUrl, 'https://picsum.photos/seed/42/400/300');
    });
  });

  group('Cause Model Value Equality', () {
    test('supports value equality comparison', () {
      const cause1 = Cause(
        id: 1,
        userId: 1,
        title: 'Title',
        description: 'Desc',
        category: 'Health',
        imageUrl: 'http://img.com',
      );

      const cause2 = Cause(
        id: 1,
        userId: 1,
        title: 'Title',
        description: 'Desc',
        category: 'Health',
        imageUrl: 'http://img.com',
      );

      expect(cause1, equals(cause2));
    });
  });
}
