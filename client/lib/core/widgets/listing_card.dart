import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../listing/domain/models/listing_model.dart';
import 'package:go_router/go_router.dart';

class ListingCard extends StatefulWidget {
  final ListingModel listing;
  const ListingCard({super.key, required this.listing});

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/listing/${widget.listing.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: widget.listing.images.isNotEmpty
                        ? Image.network(
                            widget.listing.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _imagePlaceholder(),
                          )
                        : _imagePlaceholder(),
                  ),
                ),
                // Badges
                Positioned(
                  top: AppSpacing.s2,
                  left: AppSpacing.s2,
                  child: Row(
                    children: [
                      if (widget.listing.isFeatured) _badge('FEATURED', AppColors.goldPrimary, AppColors.textInverse),
                      if (widget.listing.isVerified) ...[
                        const SizedBox(width: 4),
                        _badge('✓ VERIFIED', AppColors.success, Colors.black),
                      ],
                    ],
                  ),
                ),
                // Favorite button
                Positioned(
                  top: AppSpacing.s2,
                  right: AppSpacing.s2,
                  child: GestureDetector(
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                    child: AnimatedScale(
                      scale: _isFavorite ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? AppColors.error : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Info Section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.listing.year} ${widget.listing.make} ${widget.listing.model}',
                    style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.s1),
                  // Price
                  Text(
                    'ETB ${_formatPrice(widget.listing.price)}',
                    style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700,
                      color: AppColors.goldPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  // Specs chips
                  Row(
                    children: [
                      _specChip('${widget.listing.mileage}km'),
                      const SizedBox(width: AppSpacing.s2),
                      _specChip(widget.listing.transmission),
                      const SizedBox(width: AppSpacing.s2),
                      _specChip(widget.listing.fuelType),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textTertiary),
                      const SizedBox(width: 2),
                      Text(
                        widget.listing.location,
                        style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColors.bgTertiary,
      child: const Center(
        child: Icon(Icons.directions_car, size: 48, color: AppColors.textTertiary),
      ),
    );
  }

  Widget _badge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg, letterSpacing: 0.5),
      ),
    );
  }

  Widget _specChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.bgTertiary,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(1)}M';
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }
}
