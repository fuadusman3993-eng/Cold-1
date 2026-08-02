import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({super.key});
  @override
  State<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  int _currentStep = 0;
  final _makes = ['Toyota', 'Hyundai', 'Honda', 'Nissan', 'Suzuki', 'Mitsubishi', 'Ford', 'Kia'];
  final _transmissions = ['Automatic', 'Manual', 'CVT'];
  final _fuelTypes = ['Petrol', 'Diesel', 'Hybrid', 'Electric'];
  final _bodyTypes = ['Sedan', 'SUV', 'Hatchback', 'Pickup', 'Van', 'Bus', 'Truck', 'Coupe'];
  final _conditions = ['New', 'Excellent', 'Good', 'Fair', 'Salvage'];

  String? _selectedMake, _selectedTransmission, _selectedFuelType, _selectedBodyType, _selectedCondition;
  final _modelCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _mileageCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  final _steps = ['Vehicle Info', 'Details', 'Photos', 'Pricing', 'Description', 'Review'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text('Post a Listing'),
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(child: _buildStepContent()),
          _buildNavButtons(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
      color: AppColors.bgSecondary,
      child: Column(
        children: [
          Row(
            children: List.generate(_steps.length, (i) {
              final done = i < _currentStep;
              final active = i == _currentStep;
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 24, height: 24,
                      decoration: BoxDecoration(
                        color: done ? AppColors.goldPrimary : active ? AppColors.goldPrimary : AppColors.bgTertiary,
                        shape: BoxShape.circle,
                        border: Border.all(color: active || done ? AppColors.goldPrimary : AppColors.borderSubtle),
                      ),
                      child: Center(
                        child: done
                            ? const Icon(Icons.check, size: 14, color: AppColors.textInverse)
                            : Text('${i + 1}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                                color: active ? AppColors.textInverse : AppColors.textTertiary)),
                      ),
                    ),
                    if (i < _steps.length - 1)
                      Expanded(child: Container(
                        height: 2,
                        color: done ? AppColors.goldPrimary : AppColors.bgTertiary,
                      )),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(_steps[_currentStep], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.goldPrimary)),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: switch (_currentStep) {
        0 => _buildStep1(),
        1 => _buildStep2(),
        2 => _buildStep3Photos(),
        3 => _buildStep4Pricing(),
        4 => _buildStep5Description(),
        5 => _buildStep6Review(),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Vehicle Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s6),
        _label('Make *'),
        _dropdown(_makes, _selectedMake, 'Select Make', (v) => setState(() => _selectedMake = v)),
        const SizedBox(height: AppSpacing.s4),
        _label('Model *'),
        TextField(controller: _modelCtrl, style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(hintText: 'e.g. Corolla, Tucson')),
        const SizedBox(height: AppSpacing.s4),
        _label('Year *'),
        TextField(controller: _yearCtrl, keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(hintText: 'e.g. 2022')),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Vehicle Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s6),
        _label('Mileage (km)'),
        TextField(controller: _mileageCtrl, keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(hintText: 'e.g. 45000')),
        const SizedBox(height: AppSpacing.s4),
        _label('Transmission'),
        _chipSelector(_transmissions, _selectedTransmission, (v) => setState(() => _selectedTransmission = v)),
        const SizedBox(height: AppSpacing.s4),
        _label('Fuel Type'),
        _chipSelector(_fuelTypes, _selectedFuelType, (v) => setState(() => _selectedFuelType = v)),
        const SizedBox(height: AppSpacing.s4),
        _label('Body Type'),
        _chipSelector(_bodyTypes, _selectedBodyType, (v) => setState(() => _selectedBodyType = v)),
        const SizedBox(height: AppSpacing.s4),
        _label('Condition'),
        _chipSelector(_conditions, _selectedCondition, (v) => setState(() => _selectedCondition = v)),
      ],
    );
  }

  Widget _buildStep3Photos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Photos & Videos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s2),
        const Text('Upload at least 5 photos. Include: front, rear, sides, dashboard, odometer.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        const SizedBox(height: AppSpacing.s6),
        GridView.count(
          crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8, crossAxisSpacing: 8,
          children: List.generate(6, (i) => _uploadSlot(i)),
        ),
      ],
    );
  }

  Widget _uploadSlot(int i) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgTertiary,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.borderSubtle, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_photo_alternate_outlined, size: 28, color: AppColors.textTertiary),
          const SizedBox(height: 4),
          Text(['Front', 'Rear', 'Left', 'Right', 'Dashboard', 'Odometer'][i],
              style: const TextStyle(fontSize: 10, color: AppColors.textTertiary)),
        ],
      ),
    );
  }

  Widget _buildStep4Pricing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pricing', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s6),
        _label('Asking Price (ETB) *'),
        TextField(controller: _priceCtrl, keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
            decoration: const InputDecoration(prefixText: 'ETB  ', hintText: '0')),
        const SizedBox(height: AppSpacing.s4),
        Container(
          padding: const EdgeInsets.all(AppSpacing.s4),
          decoration: BoxDecoration(
            color: AppColors.goldShimmer,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.borderActive),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.goldPrimary, size: 20),
              SizedBox(width: AppSpacing.s3),
              Expanded(child: Text('AI Price Suggestion: ETB 3,200,000 – 3,800,000 based on similar vehicles',
                  style: TextStyle(color: AppColors.goldLight, fontSize: 13))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep5Description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s6),
        TextField(
          controller: _descCtrl,
          maxLines: 8, maxLength: 2000,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: const InputDecoration(
            hintText: 'Describe your vehicle in detail. Include any modifications, service history, or notable features...',
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }

  Widget _buildStep6Review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Review & Publish', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: AppSpacing.s6),
        _reviewRow('Make', _selectedMake ?? 'Not set'),
        _reviewRow('Model', _modelCtrl.text.isNotEmpty ? _modelCtrl.text : 'Not set'),
        _reviewRow('Year', _yearCtrl.text.isNotEmpty ? _yearCtrl.text : 'Not set'),
        _reviewRow('Mileage', _mileageCtrl.text.isNotEmpty ? '${_mileageCtrl.text} km' : 'Not set'),
        _reviewRow('Transmission', _selectedTransmission ?? 'Not set'),
        _reviewRow('Fuel Type', _selectedFuelType ?? 'Not set'),
        _reviewRow('Body Type', _selectedBodyType ?? 'Not set'),
        _reviewRow('Condition', _selectedCondition ?? 'Not set'),
        _reviewRow('Price', _priceCtrl.text.isNotEmpty ? 'ETB ${_priceCtrl.text}' : 'Not set'),
        const SizedBox(height: AppSpacing.s6),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Listing published successfully! 🎉'), backgroundColor: AppColors.success),
              );
              Navigator.pop(context);
            },
            child: const Text('Publish Listing'),
          ),
        ),
      ],
    );
  }

  Widget _reviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))),
          Expanded(child: Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildNavButtons() {
    return Container(
      padding: EdgeInsets.fromLTRB(AppSpacing.s4, AppSpacing.s3, AppSpacing.s4, MediaQuery.of(context).padding.bottom + AppSpacing.s3),
      decoration: BoxDecoration(color: AppColors.bgSecondary, border: Border(top: BorderSide(color: AppColors.borderSubtle))),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                child: const Text('Back'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: AppSpacing.s3),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _currentStep < _steps.length - 1
                  ? () => setState(() => _currentStep++)
                  : null,
              child: Text(_currentStep < _steps.length - 2 ? 'Continue' : 'Review'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s2),
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
    );
  }

  Widget _dropdown(List<String> items, String? value, String hint, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: AppColors.bgTertiary,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: const InputDecoration(),
      hint: Text(hint, style: const TextStyle(color: AppColors.textTertiary)),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _chipSelector(List<String> items, String? selected, ValueChanged<String> onChanged) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: items.map((item) {
        final isSelected = selected == item;
        return GestureDetector(
          onTap: () => onChanged(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.goldPrimary : AppColors.bgTertiary,
              borderRadius: BorderRadius.circular(AppRadius.xs),
              border: Border.all(color: isSelected ? AppColors.goldPrimary : AppColors.borderSubtle),
            ),
            child: Text(item, style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500,
              color: isSelected ? AppColors.textInverse : AppColors.textSecondary,
            )),
          ),
        );
      }).toList(),
    );
  }
}
