import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/causes/presentation/screens/cause_detail_screen.dart';
import '../../features/causes/presentation/screens/cause_list_screen.dart';
import '../../features/causes/presentation/screens/favorites_screen.dart';
import '../../features/causes/presentation/screens/main_navigation_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // ShellRoute for Bottom Navigation (Preserves tab state across navigation)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationScreen(navigationShell: navigationShell);
      },
      branches: [
        // Branch 1: Explore Cause List
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const CauseListScreen(),
            ),
          ],
        ),
        // Branch 2: Saved Favorites
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
      ],
    ),

    // Root Detail Screen Route
    GoRoute(
      path: '/cause/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final idStr = state.pathParameters['id'];
        final causeId = int.tryParse(idStr ?? '') ?? 0;
        return CauseDetailScreen(causeId: causeId);
      },
    ),
  ],
);
