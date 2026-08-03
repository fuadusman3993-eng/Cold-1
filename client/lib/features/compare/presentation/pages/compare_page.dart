import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';
import 'package:ethiodrive/features/listing/domain/models/listing_model.dart';

class ComparePage extends StatelessWidget {
  final String car1Id;
  final String car2Id;
  
  const ComparePage({super.key, required this.car1Id, required this.car2Id});

  @override
  Widget build(BuildContext context) {
    final c1 = mockListings.firstWhere((l) => l.id == car1Id, orElse: () => mockListings[0]);
    final c2 = mockListings.firstWhere((l) => l.id == car2Id, orElse: () => mockListings[1]);

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(title: const Text('Compare Vehicles'), backgroundColor: AppColors.bgPrimary),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildCarHeader(c1)),
                const SizedBox(width: AppSpacing.s4),
                Expanded(child: _buildCarHeader(c2)),
              ],
            ),
            const SizedBox(height: AppSpacing.s6),
            _buildCompareRow('Price (ETB)', _formatPrice(c1.price), _formatPrice(c2.price), isHighlight: true),
            _buildCompareRow('Year', c1.year.toString(), c2.year.toString()),
            _buildCompareRow('Mileage (km)', c1.mileage.toString(), c2.mileage.toString()),
            _buildCompareRow('Transmission', c1.transmission, c2.transmission),
            _buildCompareRow('Fuel Type', c1.fuelType, c2.fuelType),
            _buildCompareRow('Body Type', c1.bodyType, c2.bodyType),
            _buildCompareRow('Condition', c1.condition, c2.condition),
            const SizedBox(height: AppSpacing.s6),
            Container(
              padding: const EdgeInsets.all(AppSpacing.s4),
              decoration: BoxDecoration(
                color: AppColors.goldShimmer,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.borderActive),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.goldPrimary, size: 24),
                  const SizedBox(width: AppSpacing.s3),
                  Expanded(
                    child: Text(
                      'AI Verdict: ${c1.make} ${c1.model} offers better value for money, but ${c2.make} ${c2.model} has lower mileage.',
                      style: const TextStyle(color: AppColors.goldLight, fontSize: 13, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarHeader(ListingModel car) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Image.network(
            car.images.isNotEmpty ? car.images.first : 'https://via.placeholder.com/150',
            height: 120, width: double.infinity, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(height: 120, color: AppColors.bgTertiary, child: const Icon(Icons.car_crash, color: AppColors.textTertiary)),
          ),
        ),
        const SizedBox(height: AppSpacing.s3),
        Text('${car.year} ${car.make}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        Text(car.model, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildCompareRow(String label, String val1, String val2, {bool isHighlight = false}) {
    final style = TextStyle(fontSize: 14, fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500, color: isHighlight ? AppColors.goldPrimary : AppColors.textPrimary);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary, fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.s2),
          Row(
            children: [
              Expanded(child: Text(val1, style: style, textAlign: TextAlign.center)),
              Container(width: 1, height: 20, color: AppColors.borderSubtle),
              Expanded(child: Text(val2, style: style, textAlign: TextAlign.center)),
            ],
          ),
          const SizedBox(height: AppSpacing.s2),
          Divider(color: AppColors.borderSubtle, height: 1),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(2)}M';
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }
}
