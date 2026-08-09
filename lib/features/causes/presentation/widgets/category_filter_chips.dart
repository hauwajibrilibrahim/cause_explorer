import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_categories.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/cause_providers.dart';

class CategoryFilterChips extends ConsumerWidget {
  const CategoryFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final theme = Theme.of(context);

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('All Causes'),
              selected: selectedCategory == null,
              onSelected: (_) {
                ref.read(selectedCategoryProvider.notifier).state = null;
              },
              backgroundColor: theme.brightness == Brightness.light
                  ? Colors.white
                  : theme.colorScheme.surface,
              selectedColor: theme.colorScheme.primary,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: selectedCategory == null
                    ? Colors.white
                    : theme.textTheme.bodyMedium?.color,
                fontWeight: selectedCategory == null ? FontWeight.bold : FontWeight.w500,
              ),
              elevation: selectedCategory == null ? 2 : 0,
            ),
          ),
          ...AppCategories.categories.map((category) {
            final isSelected = selectedCategory == category;
            final categoryColor = AppColors.categoryColors[category] ?? theme.colorScheme.primary;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: categoryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(category),
                  ],
                ),
                selected: isSelected,
                onSelected: (_) {
                  ref.read(selectedCategoryProvider.notifier).state =
                      isSelected ? null : category;
                },
                backgroundColor: theme.brightness == Brightness.light
                    ? Colors.white
                    : theme.colorScheme.surface,
                selectedColor: categoryColor,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
                elevation: isSelected ? 2 : 0,
              ),
            );
          }),
        ],
      ),
    );
  }
}
