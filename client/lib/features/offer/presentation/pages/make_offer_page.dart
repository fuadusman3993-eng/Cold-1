import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';

class MakeOfferPage extends StatefulWidget {
  final String listingId;
  const MakeOfferPage({super.key, required this.listingId});

  @override
  State<MakeOfferPage> createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  final _amountCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _isLoading = false;

  ListingModel get _listing => mockListings.firstWhere(
    (l) => l.id == widget.listingId,
    orElse: () => mockListings.first,
  );

  @override
  Widget build(BuildContext context) {
    final listing = _listing;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text('Make an Offer'),
        backgroundColor: AppColors.bgPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListingSummary(listing),
            const SizedBox(height: AppSpacing.s6),
            const Text('Your Offer Amount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.s2),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w700),
              decoration: const InputDecoration(
                prefixText: 'ETB ',
                prefixStyle: TextStyle(color: AppColors.textSecondary, fontSize: 24, fontWeight: FontWeight.w700),
                hintText: '0',
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            Container(
              padding: const EdgeInsets.all(AppSpacing.s3),
              decoration: BoxDecoration(
                color: AppColors.goldShimmer,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.borderActive),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: AppColors.goldPrimary, size: 20),
                  SizedBox(width: AppSpacing.s3),
                  Expanded(child: Text('AI Suggestion: A strong offer would be around ETB 3,400,000 based on market value.', style: TextStyle(color: AppColors.goldLight, fontSize: 13))),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            const Text('Message to Seller (Optional)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.s2),
            TextField(
              controller: _messageCtrl,
              maxLines: 4,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'E.g., I am very interested and can pay cash today.',
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitOffer,
              child: _isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.bgPrimary))
                  : const Text('Submit Offer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListingSummary(ListingModel listing) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s3),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Image.network(
              listing.images.isNotEmpty ? listing.images.first : 'https://via.placeholder.com/150',
              width: 80, height: 80, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(width: 80, height: 80, color: AppColors.bgTertiary, child: const Icon(Icons.car_crash, color: AppColors.textTertiary)),
            ),
          ),
          const SizedBox(width: AppSpacing.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${listing.year} ${listing.make} ${listing.model}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: AppSpacing.s1),
                Text('Asking: ETB ${_formatPrice(listing.price)}', style: const TextStyle(fontSize: 14, color: AppColors.goldPrimary, fontWeight: FontWeight.w500)),
                const SizedBox(height: AppSpacing.s1),
                Text(listing.location, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(2)}M';
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }

  void _submitOffer() async {
    if (_amountCtrl.text.isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Offer sent successfully!'), backgroundColor: AppColors.success),
    );
    context.pop();
  }
}
