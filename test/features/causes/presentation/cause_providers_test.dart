import 'package:cause_explorer/features/causes/presentation/providers/cause_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Unit tests for cause providers
void main() {
  group('FavoritesNotifier Provider Unit Tests', () {
    test('initial state is empty set', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final favorites = container.read(favoritesNotifierProvider);
      expect(favorites, isEmpty);
    });

    test('toggling favorite adds and removes cause ID correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(favoritesNotifierProvider.notifier);

      // Add ID 10
      notifier.toggleFavorite(10);
      expect(container.read(favoritesNotifierProvider), contains(10));
      expect(notifier.isFavorite(10), isTrue);

      // Add ID 20
      notifier.toggleFavorite(20);
      expect(container.read(favoritesNotifierProvider), containsAll([10, 20]));

      // Toggle ID 10 off
      notifier.toggleFavorite(10);
      expect(container.read(favoritesNotifierProvider), contains(20));
      expect(container.read(favoritesNotifierProvider), isNot(contains(10)));
    });
  });

  group('Search and Category Filter State Tests', () {
    test('search query provider updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(searchQueryProvider), '');

      container.read(searchQueryProvider.notifier).state = 'Education';
      expect(container.read(searchQueryProvider), 'Education');
    });

    test('category filter provider updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(selectedCategoryProvider), isNull);

      container.read(selectedCategoryProvider.notifier).state = 'Health';
      expect(container.read(selectedCategoryProvider), 'Health');
    });
  });
}
