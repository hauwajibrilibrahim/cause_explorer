import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/cause_remote_data_source.dart';
import '../../data/repositories/cause_repository_impl.dart';
import '../../domain/models/cause.dart';
import '../../domain/repositories/cause_repository.dart';

// --- Dependency Injection Providers ---

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final causeRemoteDataSourceProvider = Provider<CauseRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CauseRemoteDataSourceImpl(dioClient: dioClient);
});

final causeRepositoryProvider = Provider<CauseRepository>((ref) {
  final remoteDataSource = ref.watch(causeRemoteDataSourceProvider);
  return CauseRepositoryImpl(remoteDataSource: remoteDataSource);
});

// --- API State Notifier ---

class CausesNotifier extends AsyncNotifier<List<Cause>> {
  @override
  Future<List<Cause>> build() async {
    final repository = ref.watch(causeRepositoryProvider);
    return repository.getCauses();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(causeRepositoryProvider);
      return repository.getCauses();
    });
  }
}

final causesAsyncNotifierProvider = AsyncNotifierProvider<CausesNotifier, List<Cause>>(
  CausesNotifier.new,
);

// --- UI Filter State Providers ---

/// Holds the current text search query
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Holds the currently selected category filter (null = "All")
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// --- Favorites State Notifier ---

class FavoritesNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() {
    return <int>{};
  }

  void toggleFavorite(int causeId) {
    if (state.contains(causeId)) {
      state = {...state}..remove(causeId);
    } else {
      state = {...state, causeId};
    }
  }

  bool isFavorite(int causeId) => state.contains(causeId);
}

final favoritesNotifierProvider = NotifierProvider<FavoritesNotifier, Set<int>>(
  FavoritesNotifier.new,
);

// --- Computed Derived Providers (Minimal Rebuild Optimization) ---

/// Derived provider that computes filtered causes based on search query and category filter.
final filteredCausesProvider = Provider<AsyncValue<List<Cause>>>((ref) {
  final causesAsync = ref.watch(causesAsyncNotifierProvider);
  final searchQuery = ref.watch(searchQueryProvider).trim().toLowerCase();
  final selectedCategory = ref.watch(selectedCategoryProvider);

  return causesAsync.whenData((causes) {
    return causes.where((cause) {
      // Search by title filter
      final matchesSearch = searchQuery.isEmpty ||
          cause.title.toLowerCase().contains(searchQuery);

      // Category filter chip
      final matchesCategory = selectedCategory == null ||
          cause.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  });
});

/// Derived provider that computes the list of favorite causes.
final favoriteCausesProvider = Provider<AsyncValue<List<Cause>>>((ref) {
  final causesAsync = ref.watch(causesAsyncNotifierProvider);
  final favorites = ref.watch(favoritesNotifierProvider);

  return causesAsync.whenData((causes) {
    return causes.where((cause) => favorites.contains(cause.id)).toList();
  });
});

/// Provider family to look up a specific cause by ID.
final causeByIdProvider = Provider.family<Cause?, int>((ref, causeId) {
  final causesAsync = ref.watch(causesAsyncNotifierProvider);
  return causesAsync.valueOrNull?.firstWhere(
    (c) => c.id == causeId,
    orElse: () => Cause(
      id: causeId,
      userId: 1,
      title: 'Cause Details',
      description: '',
      category: 'Health',
      imageUrl: '',
    ),
  );
});
