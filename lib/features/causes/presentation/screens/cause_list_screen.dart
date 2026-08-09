import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cause_providers.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/cause_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/loading_skeleton_widget.dart';
import '../widgets/search_bar_widget.dart';

class CauseListScreen extends ConsumerWidget {
  const CauseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCausesAsync = ref.watch(filteredCausesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.volunteer_activism_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Cause Explorer'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh Causes',
            onPressed: () {
              ref.read(causesAsyncNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Input Bar
          const SearchBarWidget(),

          // Category Chips Filter
          const CategoryFilterChips(),
          const SizedBox(height: 8),

          // Cause Cards List with AsyncValue Pattern
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref.read(causesAsyncNotifierProvider.notifier).refresh();
              },
              child: filteredCausesAsync.when(
                data: (causes) {
                  if (causes.isEmpty) {
                    final isFiltering = ref.read(searchQueryProvider).isNotEmpty ||
                        ref.read(selectedCategoryProvider) != null;

                    return EmptyStateWidget(
                      title: isFiltering ? 'No Matching Causes' : 'No Causes Found',
                      message: isFiltering
                          ? 'Try modifying your search text or selected category filter.'
                          : 'No social causes are available at the moment.',
                      icon: isFiltering
                          ? Icons.filter_alt_off_rounded
                          : Icons.folder_open_rounded,
                      onAction: isFiltering
                          ? () {
                              ref.read(searchQueryProvider.notifier).state = '';
                              ref.read(selectedCategoryProvider.notifier).state = null;
                            }
                          : null,
                      actionLabel: 'Reset Filters',
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
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
            ),
          ),
        ],
      ),
    );
  }
}
