import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/listing_card.dart';
import '../../../listing/domain/models/listing_model.dart';

class DealerPage extends StatelessWidget {
  final String slug;
  const DealerPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final listings = mockListings;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.bgPrimary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.goldGradient),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(color: AppColors.bgPrimary, borderRadius: BorderRadius.circular(16)),
                        child: const Icon(Icons.directions_car, size: 40, color: AppColors.goldPrimary),
                      ),
                      const SizedBox(height: AppSpacing.s2),
                      const Text('Addis Auto Gallery', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textInverse)),
                      const Text('Official Dealer • Since 2018', style: TextStyle(fontSize: 12, color: AppColors.textInverse)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s4),
              child: Row(
                children: [
                  _statBadge('148', 'Listings'),
                  const SizedBox(width: AppSpacing.s3),
                  _statBadge('4.9★', 'Rating'),
                  const SizedBox(width: AppSpacing.s3),
                  _statBadge('✓', 'Verified'),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: AppSpacing.s3, crossAxisSpacing: AppSpacing.s3, childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => ListingCard(listing: listings[i]), childCount: listings.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _statBadge(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
        decoration: BoxDecoration(color: AppColors.bgSecondary, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.borderSubtle)),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.goldPrimary)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
