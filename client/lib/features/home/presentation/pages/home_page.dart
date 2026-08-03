import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/widgets/listing_card.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _heroController = PageController();
  int _currentHeroIndex = 0;
  Timer? _heroTimer;

  @override
  void initState() {
    super.initState();
    _startHeroAutoPlay();
  }

  @override
  void dispose() {
    _heroTimer?.cancel();
    _heroController.dispose();
    super.dispose();
  }

  void _startHeroAutoPlay() {
    _heroTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_heroController.hasClients) {
        final nextIndex = (_currentHeroIndex + 1) % 3;
        _heroController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..fetchHomeData(),
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<HomeCubit>().fetchHomeData(),
          color: AppColors.goldPrimary,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildSearchBar()),
              SliverToBoxAdapter(child: _buildCategories()),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator(color: AppColors.goldPrimary)),
                    );
                  } else if (state is HomeError) {
                    return SliverFillRemaining(
                      child: Center(child: Text(state.message, style: const TextStyle(color: AppColors.error))),
                    );
                  } else if (state is HomeLoaded) {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        _buildHeroBanner(),
                        _buildSection('Recommended For You', state.recommended),
                        _buildSection('Featured Cars', state.featured),
                        _buildSection('Luxury Collection', state.luxury),
                        _buildSection('Recently Added', state.recent),
                        const SizedBox(height: AppSpacing.s48),
                      ]),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox());
                },
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Menu Button
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: AppColors.bgSecondary, // #111111
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 24),
          ),
          // Center: Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Good Morning,', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 2),
                const Text('Fuad 👋', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on, color: AppColors.goldPrimary, size: 12),
                    SizedBox(width: 4),
                    Text('Addis Ababa', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          // Right: Actions
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.bgSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_none, color: Colors.white, size: 24),
                  ),
                  Positioned(
                    right: 12, top: 12,
                    child: Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(color: AppColors.goldPrimary, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textSecondary, size: 24),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Search make, model or keyword', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.bgTertiary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.tune, color: Colors.white, size: 18),
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SizedBox(
        height: 72,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final cat = categories[index];
            final isActive = cat['active'] as bool;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 72,
              decoration: BoxDecoration(
                color: isActive ? AppColors.goldPrimary.withOpacity(0.1) : AppColors.bgSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isActive ? AppColors.goldPrimary : Colors.transparent),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    color: isActive ? AppColors.goldPrimary : Colors.white,
                    size: 26,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cat['label'] as String,
                    style: TextStyle(
                      color: isActive ? AppColors.goldPrimary : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    final banners = [
      {'image': 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?q=80&w=800', 'title': 'Luxury\nMeets Power', 'subtitle': 'Explore premium SUVs'},
      {'image': 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=800', 'title': 'Electric\nFuture', 'subtitle': 'Discover zero emissions'},
      {'image': 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?q=80&w=800', 'title': 'Sports\nCollection', 'subtitle': 'Feel the adrenaline'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: AppColors.goldPrimary.withOpacity(0.1), blurRadius: 32, offset: const Offset(0, 16)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              PageView.builder(
                controller: _heroController,
                onPageChanged: (i) => setState(() => _currentHeroIndex = i),
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(banners[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.2),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.goldPrimary.withOpacity(0.5)),
                            ),
                            child: const Text('FEATURED DEALER', style: TextStyle(color: AppColors.goldPrimary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ),
                          const Spacer(),
                          Text(banners[index]['title']!, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.1)),
                          const SizedBox(height: 8),
                          Text(banners[index]['subtitle']!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.goldPrimary,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(140, 48),
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Explore Deals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: Row(
                  children: List.generate(banners.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(left: 6),
                      width: _currentHeroIndex == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentHeroIndex == index ? AppColors.goldPrimary : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<ListingModel> items) {
    if (items.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
    
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5)),
                const Icon(Icons.arrow_forward, color: AppColors.textSecondary, size: 24),
              ],
            ),
          ),
          SizedBox(
            height: 310, // Sufficient height for the ListingCard + hover translation
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ListingCard(listing: items[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
