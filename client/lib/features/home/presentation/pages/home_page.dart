import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';
import 'package:ethiodrive/core/widgets/listing_card.dart';
import 'package:ethiodrive/core/di/injection.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';
import '../bloc/home_cubit.dart';

// ─── Categories ──────────────────────────────────────────────────────────────

const _categories = [
  _Category('All', Icons.apps_rounded, null),
  _Category('Sedan', Icons.directions_car_rounded, 'Sedan'),
  _Category('SUV', Icons.airport_shuttle_rounded, 'SUV'),
  _Category('Pickup', Icons.local_shipping_rounded, 'Pickup'),
  _Category('Electric', Icons.bolt_rounded, 'Electric'),
  _Category('Luxury', Icons.diamond_rounded, 'Luxury'),
  _Category('Van', Icons.directions_bus_rounded, 'Van'),
];

class _Category {
  final String label;
  final IconData icon;
  final String? filter;
  const _Category(this.label, this.icon, this.filter);
}

// ─── Hero banners ─────────────────────────────────────────────────────────────

const _heroBanners = [
  _HeroBanner(
    image: 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=900&q=80',
    tag: 'LUXURY',
    title: 'Find Your\nDream Car',
    sub: 'Premium vehicles at your fingertips',
    cta: 'Explore Now',
  ),
  _HeroBanner(
    image: 'https://images.unsplash.com/photo-1633158829585-23ba8f7c8caf?w=900&q=80',
    tag: 'ELECTRIC',
    title: 'Go Electric\nGo Smart',
    sub: 'Zero emissions, all the thrill',
    cta: 'View EVs',
  ),
  _HeroBanner(
    image: 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=900&q=80',
    tag: 'HOT DEALS',
    title: 'Best Deals\nThis Week',
    sub: 'Verified cars, unbeatable prices',
    cta: 'See Deals',
  ),
];

class _HeroBanner {
  final String image;
  final String tag;
  final String title;
  final String sub;
  final String cta;
  const _HeroBanner({
    required this.image,
    required this.tag,
    required this.title,
    required this.sub,
    required this.cta,
  });
}

// ─── HomePage ─────────────────────────────────────────────────────────────────

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..fetchHomeData(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final PageController _heroCtrl = PageController(viewportFraction: 1);
  final TextEditingController _searchCtrl = TextEditingController();
  int _heroIdx = 0;
  int _categoryIdx = 0;
  Timer? _heroTimer;

  @override
  void initState() {
    super.initState();
    _heroTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_heroCtrl.hasClients) {
        final next = (_heroIdx + 1) % _heroBanners.length;
        _heroCtrl.animateToPage(next,
            duration: const Duration(milliseconds: 700), curve: Curves.easeInOutCubic);
      }
    });
  }

  @override
  void dispose() {
    _heroTimer?.cancel();
    _heroCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isTablet = mq.size.width >= 600;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          return RefreshIndicator(
            onRefresh: () => ctx.read<HomeCubit>().fetchHomeData(),
            color: AppColors.goldPrimary,
            backgroundColor: AppColors.bgSecondary,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                // ── Header ──
                SliverToBoxAdapter(child: _buildHeader(ctx, mq)),
                // ── Search Bar ──
                SliverToBoxAdapter(child: _buildSearchBar(ctx, mq)),
                // ── Categories ──
                SliverToBoxAdapter(child: _buildCategories(mq)),
                // ── Hero Banner ──
                SliverToBoxAdapter(child: _buildHero(ctx, mq, isTablet)),
                // ── Content ──
                if (state is HomeLoading)
                  SliverToBoxAdapter(child: _buildShimmerSections(mq, isTablet))
                else if (state is HomeError)
                  SliverToBoxAdapter(child: _buildErrorState(ctx, state.message))
                else if (state is HomeLoaded)
                  _buildLoadedSections(ctx, state, mq, isTablet)
                else
                  SliverToBoxAdapter(child: _buildShimmerSections(mq, isTablet)),
                // ── Bottom padding for nav bar ──
                SliverToBoxAdapter(child: SizedBox(height: mq.padding.bottom + 100)),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── HEADER ───────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext ctx, MediaQueryData mq) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, mq.padding.top + 16, 20, 16),
      child: Row(
        children: [
          // Avatar / Profile
          GestureDetector(
            onTap: () => ctx.go('/profile'),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.goldPrimary, width: 2),
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Good day 👋',
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.2)),
                const Text('Find Your Perfect Car',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3)),
              ],
            ),
          ),
          // Notification
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.bgSecondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: const Icon(Icons.notifications_outlined,
                      color: Colors.white, size: 22),
                ),
                Positioned(
                  right: 10, top: 10,
                  child: Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(
                        color: AppColors.goldPrimary, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Favorites
          GestureDetector(
            onTap: () => ctx.go('/favorites'),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.bgSecondary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: const Icon(Icons.favorite_border_rounded,
                  color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ── SEARCH BAR ────────────────────────────────────────────────────────────────

  Widget _buildSearchBar(BuildContext ctx, MediaQueryData mq) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => ctx.go('/search'),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.bgSecondary,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(Icons.search_rounded,
                        color: AppColors.textTertiary, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('Search make, model…',
                          style: TextStyle(
                              color: AppColors.textTertiary, fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Filter button
          GestureDetector(
            onTap: () => _showFilterSheet(ctx),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.tune_rounded,
                  color: Colors.black, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: AppColors.bgSecondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter Cars',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            const SizedBox(height: 16),
            const Text('Price Range, Body Type, Year etc.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ctx.go('/search');
                },
                child: const Text('Open Advanced Filter'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── CATEGORIES ───────────────────────────────────────────────────────────────

  Widget _buildCategories(MediaQueryData mq) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (_, i) {
          final cat = _categories[i];
          final isActive = _categoryIdx == i;
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _categoryIdx = i);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 10, bottom: 8, top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.goldPrimary.withOpacity(0.15)
                    : AppColors.bgSecondary,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isActive
                      ? AppColors.goldPrimary
                      : AppColors.borderSubtle,
                  width: isActive ? 1.5 : 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(cat.icon,
                      size: 22,
                      color: isActive
                          ? AppColors.goldPrimary
                          : AppColors.textSecondary),
                  const SizedBox(height: 4),
                  Text(cat.label,
                      style: TextStyle(
                          fontSize: 11,
                          color: isActive
                              ? AppColors.goldPrimary
                              : AppColors.textSecondary,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w400)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── HERO BANNER ───────────────────────────────────────────────────────────────

  Widget _buildHero(BuildContext ctx, MediaQueryData mq, bool isTablet) {
    final heroH = isTablet ? 240.0 : mq.size.height * 0.24;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: SizedBox(
              height: heroH,
              child: PageView.builder(
                controller: _heroCtrl,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i) => setState(() => _heroIdx = i),
                itemCount: _heroBanners.length,
                itemBuilder: (_, i) => _HeroBannerSlide(
                  banner: _heroBanners[i],
                  onCtaTap: () => ctx.go('/search'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_heroBanners.length, (i) {
              final isActive = _heroIdx == i;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.goldPrimary
                      : AppColors.textTertiary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ── SHIMMER LOADING ───────────────────────────────────────────────────────────

  Widget _buildShimmerSections(MediaQueryData mq, bool isTablet) {
    final cardW = isTablet ? 220.0 : mq.size.width * 0.46;
    return Column(
      children: List.generate(2, (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
              child: Shimmer.fromColors(
                baseColor: AppColors.bgSecondary,
                highlightColor: AppColors.bgTertiary,
                child: Container(
                    height: 20, width: 160, color: AppColors.bgSecondary),
              ),
            ),
            SizedBox(
              height: cardW * 1.55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 3,
                itemBuilder: (_, __) => Shimmer.fromColors(
                  baseColor: AppColors.bgSecondary,
                  highlightColor: AppColors.bgTertiary,
                  child: Container(
                    width: cardW,
                    margin: const EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      color: AppColors.bgSecondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // ── ERROR STATE ───────────────────────────────────────────────────────────────

  Widget _buildErrorState(BuildContext ctx, String message) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 56, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            const Text('Could not load listings',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(message,
                style: const TextStyle(
                    color: AppColors.textTertiary, fontSize: 13),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () => ctx.read<HomeCubit>().fetchHomeData(),
              icon: const Icon(Icons.refresh_rounded,
                  color: AppColors.goldPrimary),
              label: const Text('Try Again',
                  style: TextStyle(color: AppColors.goldPrimary)),
            ),
          ],
        ),
      ),
    );
  }

  // ── LOADED SECTIONS ───────────────────────────────────────────────────────────

  Widget _buildLoadedSections(
      BuildContext ctx, HomeLoaded state, MediaQueryData mq, bool isTablet) {
    final cardW = isTablet ? 220.0 : mq.size.width * 0.46;
    final sections = [
      _SectionData('Recommended For You', state.recommended),
      _SectionData('Featured Cars', state.featured),
      _SectionData('Luxury Collection', state.luxury),
      _SectionData('Recently Added', state.recent),
    ];

    final nonEmpty = sections.where((s) => s.items.isNotEmpty).toList();

    if (nonEmpty.isEmpty) {
      return SliverToBoxAdapter(child: _buildEmptyState(ctx));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => _buildSection(ctx, nonEmpty[i], cardW),
        childCount: nonEmpty.length,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext ctx) {
    return SizedBox(
      height: 320,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.bgSecondary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: const Icon(Icons.directions_car_outlined,
                  size: 38, color: AppColors.textTertiary),
            ),
            const SizedBox(height: 20),
            const Text('No Cars Yet',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Be the first to list your car!',
                style: TextStyle(
                    color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => ctx.go('/sell'),
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text('Sell Your Car'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext ctx, _SectionData section, double cardW) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(section.title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3)),
              GestureDetector(
                onTap: () => ctx.go('/search'),
                child: Row(
                  children: const [
                    Text('See All',
                        style: TextStyle(
                            color: AppColors.goldPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.goldPrimary, size: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: cardW * 1.56,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: section.items.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(right: 14),
              child: ListingCard(listing: section.items[i], width: cardW),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Hero Banner Slide Widget ─────────────────────────────────────────────────

class _HeroBannerSlide extends StatelessWidget {
  final _HeroBanner banner;
  final VoidCallback onCtaTap;
  const _HeroBannerSlide({required this.banner, required this.onCtaTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: banner.image,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: AppColors.bgTertiary),
          errorWidget: (_, __, ___) => Container(color: AppColors.bgTertiary),
        ),
        // Dark gradient
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.75),
              ],
              stops: const [0.3, 1.0],
            ),
          ),
        ),
        // Content
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tag pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(banner.tag,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1)),
              ),
              const SizedBox(height: 8),
              Text(banner.title,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.15,
                      letterSpacing: -0.5)),
              const SizedBox(height: 4),
              Text(banner.sub,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 14),
              // CTA
              GestureDetector(
                onTap: onCtaTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.goldPrimary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(banner.cta,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_rounded,
                          color: Colors.black, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Helper ───────────────────────────────────────────────────────────────────

class _SectionData {
  final String title;
  final List<ListingModel> items;
  const _SectionData(this.title, this.items);
}
