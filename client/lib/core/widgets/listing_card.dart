import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';

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
        width: 220,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A), // Darker grey matching image
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: widget.listing.images.isNotEmpty
                        ? Image.network(
                            widget.listing.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _imagePlaceholder(),
                          )
                        : _imagePlaceholder(),
                  ),
                ),
                // Verified Badge (Bottom Left)
                if (widget.listing.isVerified)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.check_circle, color: AppColors.goldPrimary, size: 12),
                          SizedBox(width: 4),
                          Text(
                            'VERIFIED',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Favorite Button (Top Right)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Details Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.listing.make} ${widget.listing.model}\n${widget.listing.year}',
                    style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600,
                      color: Colors.white, height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${_formatPrice(widget.listing.price)}',
                    style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold,
                      color: AppColors.goldPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.listing.mileage} km • ${widget.listing.transmission}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        widget.listing.location,
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const Spacer(),
                      const Icon(Icons.bookmark_border, size: 18, color: Colors.grey),
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
      color: const Color(0xFF2A2A2A),
      child: const Center(
        child: Icon(Icons.directions_car, size: 48, color: Colors.grey),
      ),
    );
  }

  String _formatPrice(double price) {
    // Standard comma separation
    return price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
