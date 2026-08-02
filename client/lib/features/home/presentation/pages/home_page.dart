import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';
import 'package:ethiodrive/core/widgets/listing_card.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildSearchBar(),
          _buildFeaturedSection(),
          _buildSectionHeader('Recently Added'),
          _buildListingGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppColors.bgPrimary,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
            child: const Icon(Icons.directions_car, color: AppColors.textInverse, size: 18),
          ),
          const SizedBox(width: 8),
          const Text('EthioDrive', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.goldPrimary, letterSpacing: -0.3)),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary)),
        const SizedBox(width: 4),
      ],
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.s4, AppSpacing.s2, AppSpacing.s4, AppSpacing.s4),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.bgTertiary,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: const Border.fromBorderSide(BorderSide(color: AppColors.borderSubtle)),
          ),
          child: const Row(
            children: [
              SizedBox(width: AppSpacing.s4),
              Icon(Icons.search, color: AppColors.textTertiary, size: 22),
              SizedBox(width: AppSpacing.s3),
              Text('Search make, model, or keyword...', style: TextStyle(color: AppColors.textTertiary, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildFeaturedSection() {
    final featured = mockListings.where((l) => l.isFeatured).toList();
    if (featured.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.s4, 0, AppSpacing.s4, AppSpacing.s3),
            child: Row(
              children: [
                Container(width: 3, height: 18, decoration: BoxDecoration(gradient: AppColors.goldGradient, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: AppSpacing.s2),
                const Text('Featured Listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: AppColors.goldPrimary, fontSize: 13))),
              ],
            ),
          ),
          SizedBox(
            height: 260,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
              scrollDirection: Axis.horizontal,
              itemCount: featured.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.s3),
              itemBuilder: (ctx, i) => SizedBox(width: 240, child: ListingCard(listing: featured[i])),
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.s4, 0, AppSpacing.s4, AppSpacing.s3),
        child: Row(
          children: [
            Container(width: 3, height: 18, decoration: BoxDecoration(gradient: AppColors.goldGradient, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: AppSpacing.s2),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: AppColors.goldPrimary, fontSize: 13))),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildListingGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: AppSpacing.s3, crossAxisSpacing: AppSpacing.s3, childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => ListingCard(listing: mockListings[i]),
          childCount: mockListings.length,
        ),
      ),
    );
  }
}
