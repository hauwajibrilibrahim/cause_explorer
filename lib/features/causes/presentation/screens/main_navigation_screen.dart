import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cause_providers.dart';

class MainNavigationScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesCount = ref.watch(
      favoritesNotifierProvider.select((favorites) => favorites.length),
    );
    final theme = Theme.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        indicatorColor: theme.colorScheme.primary.withValues(alpha: 0.15),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded, color: AppColors.primary),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Badge(
              label: favoritesCount > 0 ? Text('$favoritesCount') : null,
              isLabelVisible: favoritesCount > 0,
              child: const Icon(Icons.favorite_border_rounded),
            ),
            selectedIcon: Badge(
              label: favoritesCount > 0 ? Text('$favoritesCount') : null,
              isLabelVisible: favoritesCount > 0,
              child: const Icon(Icons.favorite_rounded, color: AppColors.favoriteRed),
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class AppColors {
  static const primary = Color(0xFF0F766E);
  static const favoriteRed = Color(0xFFEF4444);
}
