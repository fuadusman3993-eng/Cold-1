import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';

class ListingCard extends StatefulWidget {
  final ListingModel listing;
  final double? width;
  const ListingCard({super.key, required this.listing, this.width});

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  bool _isHovering = false;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  // Curated real car images by make
  static const Map<String, String> _carImages = {
    'toyota': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=600&q=80',
    'hyundai': 'https://images.unsplash.com/photo-1635366860264-cd0e2a4ca820?w=600&q=80',
    'honda': 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=600&q=80',
    'bmw': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=600&q=80',
    'mercedes': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=600&q=80',
    'audi': 'https://images.unsplash.com/photo-1568992687947-868a62a9f521?w=600&q=80',
    'nissan': 'https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=600&q=80',
    'kia': 'https://images.unsplash.com/photo-1670526657042-1c5e21ef6da7?w=600&q=80',
    'mazda': 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=600&q=80',
    'ford': 'https://images.unsplash.com/photo-1561040189-f42a4b79f5f5?w=600&q=80',
  };

  String _getImageUrl() {
    if (widget.listing.images.isNotEmpty) return widget.listing.images.first;
    final key = widget.listing.make.toLowerCase();
    return _carImages[key] ??
        'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600&q=80';
  }

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _pulse = Tween<double>(begin: 1, end: 1.3).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    _pulseCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.width ?? 200.0;
    final imageH = cardWidth * 0.62;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => context.push('/listing/${widget.listing.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          width: cardWidth,
          transform: Matrix4.translationValues(0, _isHovering ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.bgSecondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovering
                  ? AppColors.goldPrimary.withOpacity(0.4)
                  : AppColors.borderSubtle,
              width: _isHovering ? 1.5 : 1,
            ),
            boxShadow: [
              if (_isHovering)
                BoxShadow(
                    color: AppColors.goldPrimary.withOpacity(0.18),
                    blurRadius: 28,
                    spreadRadius: 2,
                    offset: const Offset(0, 8))
              else
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImageSection(imageH),
              _buildDetailsSection(cardWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(double imageH) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SizedBox(
            height: imageH,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: _getImageUrl(),
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: AppColors.bgTertiary,
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.goldPrimary,
                    ),
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.bgTertiary,
                child: const Center(
                  child: Icon(Icons.directions_car, size: 40, color: AppColors.textTertiary),
                ),
              ),
            ),
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.35),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
        ),
        // Verified badge
        if (widget.listing.isVerified)
          Positioned(
            bottom: 8,
            left: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.goldPrimary.withOpacity(0.6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.verified_rounded, color: AppColors.goldPrimary, size: 10),
                      SizedBox(width: 3),
                      Text('VERIFIED',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.8)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        // Favorite button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: _toggleFavorite,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: Center(
                    child: ScaleTransition(
                      scale: _pulse,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, anim) =>
                            ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          key: ValueKey(_isFavorite),
                          color: _isFavorite ? const Color(0xFFF87171) : Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Featured badge
        if (widget.listing.isFeatured)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('FEATURED',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.8)),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailsSection(double cardWidth) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Make + Model
          Text(
            '${widget.listing.make} ${widget.listing.model}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Year + Body type
          Text(
            '${widget.listing.year} · ${widget.listing.bodyType}',
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          // Price
          Text(
            'ETB ${_formatPrice(widget.listing.price)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.goldPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          // Specs row
          _SpecChip(
            icon: Icons.speed_rounded,
            label: '${_formatMileage(widget.listing.mileage)} km',
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: _SpecChip(
                  icon: Icons.settings_rounded,
                  label: widget.listing.transmission.length > 5
                      ? widget.listing.transmission.substring(0, 5)
                      : widget.listing.transmission,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _SpecChip(
                  icon: Icons.local_gas_station_rounded,
                  label: widget.listing.fuelType.length > 5
                      ? widget.listing.fuelType.substring(0, 5)
                      : widget.listing.fuelType,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Location
          Row(
            children: [
              const Icon(Icons.location_on_rounded, size: 12, color: AppColors.textTertiary),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  widget.listing.location,
                  style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(1)}M';
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }

  String _formatMileage(int mileage) {
    return mileage.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }
}

class _SpecChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SpecChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: AppColors.textTertiary),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
