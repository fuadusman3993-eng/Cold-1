import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';
import 'package:ethiodrive/core/widgets/listing_card.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = mockListings.where((l) => l.isVerified).toList();
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(title: const Text('Favorites'), backgroundColor: AppColors.bgPrimary),
      body: favorites.isEmpty
          ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.favorite_border, size: 64, color: AppColors.textTertiary),
              SizedBox(height: AppSpacing.s4),
              Text('No favorites yet', style: TextStyle(fontSize: 18, color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              SizedBox(height: AppSpacing.s2),
              Text('Tap the heart icon on any listing to save it here.', style: TextStyle(color: AppColors.textSecondary, fontSize: 14), textAlign: TextAlign.center),
            ]))
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.s4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: AppSpacing.s3, crossAxisSpacing: AppSpacing.s3, childAspectRatio: 0.72,
              ),
              itemCount: favorites.length,
              itemBuilder: (ctx, i) => ListingCard(listing: favorites[i]),
            ),
    );
  }
}
