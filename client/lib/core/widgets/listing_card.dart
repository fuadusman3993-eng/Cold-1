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

class _ListingCardState extends State<ListingCard>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  static const Map<String, String> _carImages = {
    'toyota':
        'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=600&q=80',
    'hyundai':
        'https://images.unsplash.com/photo-1635366860264-cd0e2a4ca820?w=600&q=80',
    'honda':
        'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=600&q=80',
    'bmw':
        'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=600&q=80',
    'mercedes':
        'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=600&q=80',
    'audi':
        'https://images.unsplash.com/photo-1568992687947-868a62a9f521?w=600&q=80',
    'nissan':
        'https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=600&q=80',
    'kia':
        'https://images.unsplash.com/photo-1670526657042-1c5e21ef6da7?w=600&q=80',
    'mazda':
        'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=600&q=80',
    'ford':
        'https://images.unsplash.com/photo-1561040189-f42a4b79f5f5?w=600&q=80',
    'land cruiser':
        'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=600&q=80',
  };

  String _getImageUrl() {
    if (widget.listing.images.isNotEmpty) return widget.listing.images.first;
    final make = widget.listing.make.toLowerCase();
    final model =
        '${widget.listing.make} ${widget.listing.model}'.toLowerCase();
    return _carImages[model] ??
        _carImages[make] ??
        'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=600&q=80';
  }

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _pulse = Tween<double>(begin: 1, end: 1.35)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width ?? 180.0;
    // Responsive font scale: smaller card → smaller text
    final scale = (w / 200).clamp(0.75, 1.0);

    return GestureDetector(
      onTap: () => context.push('/listing/${widget.listing.id}'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: w,
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(w, scale),
            _buildDetails(scale),
          ],
        ),
      ),
    );
  }

  // ─── Image ────────────────────────────────────────────────────────────────

  Widget _buildImage(double w, double scale) {
    final imgH = w * 0.60;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          child: SizedBox(
            height: imgH,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: _getImageUrl(),
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: AppColors.bgTertiary,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 1.5, color: AppColors.goldPrimary),
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.bgTertiary,
                child: const Center(
                  child: Icon(Icons.directions_car_rounded,
                      size: 36, color: AppColors.textTertiary),
                ),
              ),
            ),
          ),
        ),
        // Gradient
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
        ),
        // Featured badge (top-left)
        if (widget.listing.isFeatured)
          Positioned(
            top: 7,
            left: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('FEATURED',
                  style: TextStyle(
                      fontSize: 8 * scale,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.6)),
            ),
          ),
        // Verified badge (bottom-left)
        if (widget.listing.isVerified)
          Positioned(
            bottom: 7,
            left: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: AppColors.goldPrimary.withOpacity(0.6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded,
                          color: AppColors.goldPrimary, size: 9 * scale),
                      SizedBox(width: 2 * scale),
                      Text('VERIFIED',
                          style: TextStyle(
                              fontSize: 8 * scale,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.6)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        // Favorite (top-right)
        Positioned(
          top: 7,
          right: 7,
          child: GestureDetector(
            onTap: () {
              setState(() => _isFavorite = !_isFavorite);
              _pulseCtrl.forward(from: 0);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: Center(
                    child: ScaleTransition(
                      scale: _pulse,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, anim) =>
                            ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          _isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          key: ValueKey(_isFavorite),
                          color: _isFavorite
                              ? const Color(0xFFF87171)
                              : Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Details ──────────────────────────────────────────────────────────────

  Widget _buildDetails(double scale) {
    final p = 10.0 * scale.clamp(0.8, 1.0);
    return Padding(
      padding: EdgeInsets.all(p),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Make + Model
          Text(
            '${widget.listing.make} ${widget.listing.model}',
            style: TextStyle(
              fontSize: 13 * scale,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2 * scale),
          // Year · Body
          Text(
            '${widget.listing.year} · ${widget.listing.bodyType}',
            style: TextStyle(
                fontSize: 10 * scale, color: AppColors.textSecondary),
            maxLines: 1,
          ),
          SizedBox(height: 6 * scale),
          // Price
          Text(
            'ETB ${_formatPrice(widget.listing.price)}',
            style: TextStyle(
              fontSize: 16 * scale,
              fontWeight: FontWeight.w800,
              color: AppColors.goldPrimary,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 6 * scale),
          // Mileage
          Row(
            children: [
              Icon(Icons.speed_rounded,
                  size: 11 * scale, color: AppColors.textTertiary),
              SizedBox(width: 3 * scale),
              Text(
                '${_formatMileage(widget.listing.mileage)} km',
                style: TextStyle(
                    fontSize: 10 * scale, color: AppColors.textTertiary),
              ),
            ],
          ),
          SizedBox(height: 4 * scale),
          // Transmission · Fuel — both always visible
          Row(
            children: [
              Expanded(
                child: _MiniTag(
                  icon: Icons.settings_rounded,
                  label: _shortTrans(widget.listing.transmission),
                  scale: scale,
                ),
              ),
              SizedBox(width: 4 * scale),
              Expanded(
                child: _MiniTag(
                  icon: Icons.local_gas_station_rounded,
                  label: _shortFuel(widget.listing.fuelType),
                  scale: scale,
                ),
              ),
            ],
          ),
          SizedBox(height: 5 * scale),
          // Location
          Row(
            children: [
              Icon(Icons.location_on_rounded,
                  size: 10 * scale, color: AppColors.textTertiary),
              SizedBox(width: 2 * scale),
              Expanded(
                child: Text(
                  widget.listing.location,
                  style: TextStyle(
                      fontSize: 10 * scale, color: AppColors.textTertiary),
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

  // ─── Helpers ──────────────────────────────────────────────────────────────

  String _shortTrans(String t) {
    if (t.toLowerCase().startsWith('auto')) return 'Auto';
    if (t.toLowerCase().startsWith('man')) return 'Manual';
    return t.length > 6 ? t.substring(0, 6) : t;
  }

  String _shortFuel(String f) {
    if (f.toLowerCase() == 'petrol') return 'Petrol';
    if (f.toLowerCase() == 'diesel') return 'Diesel';
    if (f.toLowerCase().contains('electric')) return 'Electric';
    if (f.toLowerCase().contains('hybrid')) return 'Hybrid';
    return f.length > 7 ? f.substring(0, 7) : f;
  }

  String _formatPrice(double price) {
    if (price >= 1000000)
      return '${(price / 1000000).toStringAsFixed(1)}M';
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }

  String _formatMileage(int m) => m
      .toString()
      .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (x) => '${x[1]},');
}

// ─── Mini tag chip ────────────────────────────────────────────────────────────

class _MiniTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final double scale;
  const _MiniTag({required this.icon, required this.label, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 5 * scale, vertical: 3 * scale),
      decoration: BoxDecoration(
        color: AppColors.bgTertiary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 9 * scale, color: AppColors.textTertiary),
          SizedBox(width: 3 * scale),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 10 * scale, color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
