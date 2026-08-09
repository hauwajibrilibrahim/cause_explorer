import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/cause_providers.dart';

class FavoriteButton extends ConsumerWidget {
  final int causeId;
  final double size;

  const FavoriteButton({
    super.key,
    required this.causeId,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch this specific cause's favorite status to avoid rebuilding whole list item
    final isFavorite = ref.watch(
      favoritesNotifierProvider.select((favorites) => favorites.contains(causeId)),
    );

    return InkWell(
      onTap: () {
        ref.read(favoritesNotifierProvider.notifier).toggleFavorite(causeId);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite ? 'Removed from favorites' : 'Added to favorites!',
            ),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isFavorite
              ? AppColors.favoriteRed.withValues(alpha: 0.12)
              : Colors.black.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            key: ValueKey<bool>(isFavorite),
            color: isFavorite ? AppColors.favoriteRed : Colors.white,
            size: size,
          ),
        ),
      ),
    );
  }
}
