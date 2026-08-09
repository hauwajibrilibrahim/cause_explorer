import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cause_providers.dart';
import '../widgets/cause_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/loading_skeleton_widget.dart';

// Favorites screen for displaying favorite causes
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteCausesAsync = ref.watch(favoriteCausesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Favorites'),
      ),
      body: favoriteCausesAsync.when(
        data: (causes) {
          if (causes.isEmpty) {
            return const EmptyStateWidget(
              title: 'No Favorites Yet',
              message:
                  'Explore causes and tap the heart icon to save your favorite social causes here.',
              icon: Icons.favorite_border_rounded,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: causes.length,
            itemBuilder: (context, index) {
              final cause = causes[index];
              return CauseCard(cause: cause);
            },
          );
        },
        loading: () => const LoadingSkeletonWidget(),
        error: (error, stackTrace) => ErrorStateWidget(
          message: error.toString(),
          onRetry: () {
            ref.read(causesAsyncNotifierProvider.notifier).refresh();
          },
        ),
      ),
    );
  }
}
