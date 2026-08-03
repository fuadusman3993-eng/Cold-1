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
      backgroundColor: Colors.black, // Darkest background matching image
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(child: _buildHeroBanner()),
            _buildSection('Recommended For You', mockListings.take(3).toList()),
            _buildSection('Trending This Week', mockListings.skip(1).take(3).toList()),
            _buildSection('Recently Added', mockListings.skip(2).take(3).toList()),
            const SliverToBoxAdapter(child: SizedBox(height: 100)), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
      child: Row(
        children: [
          // Menu Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 20),
          ),
          const SizedBox(width: AppSpacing.s3),
          // Greeting & Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Good Morning,', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const Text('Fuad 👋', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined, color: Colors.grey, size: 12),
                    SizedBox(width: 2),
                    Text('Addis Ababa, Ethiopia', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 14),
                  ],
                ),
              ],
            ),
          ),
          // Notifications
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
              ),
              Positioned(
                right: 6, top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppColors.goldPrimary, shape: BoxShape.circle),
                  child: const Text('3', style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.s2),
          // Avatar
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=11'), // Placeholder avatar
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.s4, AppSpacing.s2, AppSpacing.s4, AppSpacing.s4),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSpacing.s4),
            const Icon(Icons.search, color: Colors.grey, size: 20),
            const SizedBox(width: AppSpacing.s3),
            const Expanded(
              child: Text('Search make, model or keyword', style: TextStyle(color: Colors.grey, fontSize: 14)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.tune, color: Colors.grey, size: 20), // Filter icon
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.directions_car, 'label': 'All Cars', 'active': true},
      {'icon': Icons.directions_car_outlined, 'label': 'Sedan', 'active': false},
      {'icon': Icons.airport_shuttle_outlined, 'label': 'SUV', 'active': false},
      {'icon': Icons.local_shipping_outlined, 'label': 'Pickup', 'active': false},
      {'icon': Icons.electrical_services_outlined, 'label': 'Electric', 'active': false},
      {'icon': Icons.diamond_outlined, 'label': 'Luxury', 'active': false},
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.s3),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isActive = cat['active'] as bool;
          return Column(
            children: [
              Container(
                width: 64, height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isActive ? AppColors.goldPrimary : Colors.grey.withOpacity(0.3)),
                ),
                child: Icon(
                  cat['icon'] as IconData,
                  color: isActive ? AppColors.goldPrimary : Colors.grey,
                  size: 24,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                cat['label'] as String,
                style: TextStyle(
                  color: isActive ? AppColors.goldPrimary : Colors.grey,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(mockListings.first.images.first), // Using first listing image as background
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.stars, color: AppColors.goldPrimary, size: 12),
                    SizedBox(width: 4),
                    Text('FEATURED DEALER', style: TextStyle(color: AppColors.goldPrimary, fontSize: 9, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Spacer(),
              const Text('Luxury\nMeets Power', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.1)),
              const SizedBox(height: 6),
              const Text('Explore premium cars\nfrom verified dealers', style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldPrimary,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(120, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Explore Deals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<ListingModel> items) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.s4, AppSpacing.s4, AppSpacing.s4, AppSpacing.s3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                const Text('See All', style: TextStyle(fontSize: 12, color: AppColors.goldPrimary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(
            height: 280, // Height for the card
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (ctx, i) => ListingCard(listing: items[i]),
            ),
          ),
        ],
      ),
    );
  }
}
