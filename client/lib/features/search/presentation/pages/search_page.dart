import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/listing_card.dart';
import '../../../listing/domain/models/listing_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _query = '';
  bool _showFilters = false;
  String? _selectedMake;
  String? _selectedBodyType;
  RangeValues _priceRange = const RangeValues(0, 10000000);

  static const _makes = ['Toyota', 'Hyundai', 'Honda', 'Nissan', 'Suzuki', 'Mitsubishi', 'Ford'];
  static const _bodyTypes = ['Sedan', 'SUV', 'Hatchback', 'Pickup', 'Van', 'Coupe'];

  List<ListingModel> get _results => mockListings.where((l) {
    final q = _query.toLowerCase();
    final matchesQuery = q.isEmpty || '${l.make} ${l.model} ${l.year}'.toLowerCase().contains(q);
    final matchesMake = _selectedMake == null || l.make == _selectedMake;
    final matchesBody = _selectedBodyType == null || l.bodyType == _selectedBodyType;
    final matchesPrice = l.price >= _priceRange.start && l.price <= _priceRange.end;
    return matchesQuery && matchesMake && matchesBody && matchesPrice;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            if (_showFilters) _buildFilters(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s2),
              child: Row(
                children: [
                  Text(
                    '${_results.length} vehicles found',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => setState(() => _showFilters = !_showFilters),
                    icon: Icon(
                      Icons.tune, size: 16,
                      color: _showFilters ? AppColors.goldPrimary : AppColors.textSecondary,
                    ),
                    label: Text(
                      'Filters',
                      style: TextStyle(
                        color: _showFilters ? AppColors.goldPrimary : AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _results.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSpacing.s3,
                        crossAxisSpacing: AppSpacing.s3,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: _results.length,
                      itemBuilder: (ctx, i) => ListingCard(listing: _results[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: TextField(
        controller: _controller,
        autofocus: false,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search make, model, or keyword...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textTertiary),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  onPressed: () => setState(() { _controller.clear(); _query = ''; }),
                  icon: const Icon(Icons.clear, color: AppColors.textTertiary, size: 18),
                )
              : null,
        ),
        onChanged: (v) => setState(() => _query = v),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.s4, 0, AppSpacing.s4, AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Make filter
          const Text('Make', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.s2),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _makes.map((m) => _filterChip(m, _selectedMake == m, () {
              setState(() => _selectedMake = _selectedMake == m ? null : m);
            })).toList(),
          ),
          const SizedBox(height: AppSpacing.s3),
          // Body type filter
          const Text('Body Type', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.s2),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _bodyTypes.map((b) => _filterChip(b, _selectedBodyType == b, () {
              setState(() => _selectedBodyType = _selectedBodyType == b ? null : b);
            })).toList(),
          ),
          const SizedBox(height: AppSpacing.s3),
          // Price range
          const Text('Price Range (ETB)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
          RangeSlider(
            values: _priceRange,
            min: 0, max: 10000000,
            activeColor: AppColors.goldPrimary,
            inactiveColor: AppColors.bgQuaternary,
            onChanged: (v) => setState(() => _priceRange = v),
            labels: RangeLabels(
              '${(_priceRange.start / 1000000).toStringAsFixed(1)}M',
              '${(_priceRange.end / 1000000).toStringAsFixed(1)}M',
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.goldPrimary : AppColors.bgTertiary,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(color: selected ? AppColors.goldPrimary : AppColors.borderSubtle),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500,
            color: selected ? AppColors.textInverse : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.textTertiary),
          SizedBox(height: AppSpacing.s4),
          Text('No vehicles found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          SizedBox(height: AppSpacing.s2),
          Text('Try adjusting your filters or search terms', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }
}
