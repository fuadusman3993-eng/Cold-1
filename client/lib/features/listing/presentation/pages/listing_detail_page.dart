import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';
import 'package:go_router/go_router.dart';

class ListingDetailPage extends StatefulWidget {
  final String listingId;
  const ListingDetailPage({super.key, required this.listingId});

  @override
  State<ListingDetailPage> createState() => _ListingDetailPageState();
}

class _ListingDetailPageState extends State<ListingDetailPage> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  ListingModel get _listing => mockListings.firstWhere(
    (l) => l.id == widget.listingId,
    orElse: () => mockListings.first,
  );

  @override
  Widget build(BuildContext context) {
    final listing = _listing;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 800;
          if (isDesktop) {
            return _buildDesktopLayout(listing);
          }
          return _buildMobileLayout(listing);
        },
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 800 ? _buildActionBar(listing) : null,
    );
  }

  Widget _buildDesktopLayout(ListingModel listing) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: double.infinity,
            color: AppColors.bgTertiary,
            child: Stack(
              children: [
                listing.images.isEmpty
                  ? const Center(child: Icon(Icons.directions_car, size: 80, color: AppColors.textTertiary))
                  : PageView.builder(
                      itemCount: listing.images.length,
                      onPageChanged: (i) => setState(() => _currentImageIndex = i),
                      itemBuilder: (ctx, i) => Image.network(listing.images[i], fit: BoxFit.cover),
                    ),
                Positioned(
                  top: 24, left: 24,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(30)),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: AppColors.bgPrimary,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.s6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleSection(listing),
                        const SizedBox(height: AppSpacing.s6),
                        _buildSpecsGrid(listing),
                        const SizedBox(height: AppSpacing.s6),
                        _buildDivider(),
                        _buildDescription(listing),
                        const SizedBox(height: AppSpacing.s6),
                        _buildDivider(),
                        _buildSellerCard(listing),
                      ],
                    ),
                  ),
                ),
                _buildActionBar(listing),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(ListingModel listing) {
    return CustomScrollView(
      slivers: [
        _buildImageHeader(listing),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSection(listing),
                const SizedBox(height: AppSpacing.s4),
                _buildSpecsGrid(listing),
                const SizedBox(height: AppSpacing.s4),
                _buildDivider(),
                _buildDescription(listing),
                const SizedBox(height: AppSpacing.s4),
                _buildDivider(),
                _buildSellerCard(listing),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildImageHeader(ListingModel listing) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.bgPrimary,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isFavorite = !_isFavorite),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? AppColors.error : Colors.white, size: 20,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: listing.images.isEmpty
            ? Container(
                color: AppColors.bgTertiary,
                child: const Center(child: Icon(Icons.directions_car, size: 80, color: AppColors.textTertiary)),
              )
            : PageView.builder(
                itemCount: listing.images.length,
                onPageChanged: (i) => setState(() => _currentImageIndex = i),
                itemBuilder: (ctx, i) => Image.network(listing.images[i], fit: BoxFit.cover),
              ),
      ),
    );
  }

  Widget _buildTitleSection(ListingModel listing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (listing.isVerified)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.success.withOpacity(0.5)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, size: 12, color: AppColors.success),
                    SizedBox(width: 4),
                    Text('VERIFIED', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.success, letterSpacing: 0.5)),
                  ],
                ),
              ),
            const Spacer(),
            Text(listing.location, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
            const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textTertiary),
          ],
        ),
        const SizedBox(height: AppSpacing.s2),
        Text('${listing.year} ${listing.make} ${listing.model}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s2),
        Text('ETB ${_formatPrice(listing.price)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.goldPrimary)),
      ],
    );
  }

  Widget _buildSpecsGrid(ListingModel listing) {
    final specs = [
      ['Mileage', '${listing.mileage.toString()}km', Icons.speed_outlined],
      ['Transmission', listing.transmission, Icons.settings_outlined],
      ['Fuel Type', listing.fuelType, Icons.local_gas_station_outlined],
      ['Body Type', listing.bodyType, Icons.directions_car_outlined],
      ['Condition', listing.condition, Icons.star_outline],
      ['Year', listing.year.toString(), Icons.calendar_today_outlined],
    ];
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width >= 800 ? 2 : 3, shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.s3,
      crossAxisSpacing: AppSpacing.s3,
      childAspectRatio: MediaQuery.of(context).size.width >= 800 ? 1.8 : 1.3,
      children: specs.map((s) => Container(
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(s[2] as IconData, size: 20, color: AppColors.goldPrimary),
            const SizedBox(height: 4),
            Text(s[1] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary), textAlign: TextAlign.center),
            Text(s[0] as String, style: const TextStyle(fontSize: 10, color: AppColors.textTertiary)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildDescription(ListingModel listing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.s4),
        const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s2),
        Text(listing.description, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
      ],
    );
  }

  Widget _buildSellerCard(ListingModel listing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.s4),
        const Text('Seller', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s3),
        Container(
          padding: const EdgeInsets.all(AppSpacing.s4),
          decoration: BoxDecoration(
            color: AppColors.bgSecondary,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24, backgroundColor: AppColors.goldPrimary,
                child: Text(listing.sellerName[0], style: const TextStyle(color: AppColors.textInverse, fontWeight: FontWeight.w700, fontSize: 18)),
              ),
              const SizedBox(width: AppSpacing.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listing.sellerName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const Text('Individual Seller', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textTertiary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionBar(ListingModel listing) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppSpacing.s4, AppSpacing.s3, AppSpacing.s4, MediaQuery.of(context).padding.bottom + AppSpacing.s3),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => context.push('/offer/${listing.id}'),
              icon: const Icon(Icons.local_offer_outlined, size: 18),
              label: const Text('Make Offer'),
            ),
          ),
          const SizedBox(width: AppSpacing.s3),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_outlined, size: 18, color: AppColors.textInverse),
              label: const Text('Contact Seller'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Divider(color: AppColors.borderSubtle, height: 1);

  String _formatPrice(double price) {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(2)}M';
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }
}
