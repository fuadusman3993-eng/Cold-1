import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class ProfileCompletionPage extends StatefulWidget {
  const ProfileCompletionPage({super.key});
  @override
  State<ProfileCompletionPage> createState() => _ProfileCompletionPageState();
}

class _ProfileCompletionPageState extends State<ProfileCompletionPage> {
  final _nameCtrl = TextEditingController();
  String? _selectedType;
  String? _selectedCity;
  static const _types = ['Buyer', 'Seller', 'Dealer'];
  static const _cities = ['Addis Ababa', 'Dire Dawa', 'Mekele', 'Hawassa', 'Bahir Dar', 'Gondar', 'Jimma', 'Adama'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(title: const Text('Complete Profile'), backgroundColor: AppColors.bgPrimary),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tell us about yourself', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.s2),
            const Text('This helps us personalize your EthioDrive experience.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.s8),
            const Text('Full Name *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.s2),
            TextField(controller: _nameCtrl, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(hintText: 'e.g. Abebe Kebede')),
            const SizedBox(height: AppSpacing.s4),
            const Text('I am a...', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.s2),
            Row(
              children: _types.map((t) {
                final selected = _selectedType == t;
                return Expanded(child: GestureDetector(
                  onTap: () => setState(() => _selectedType = t),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.goldPrimary : AppColors.bgTertiary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: selected ? AppColors.goldPrimary : AppColors.borderSubtle),
                    ),
                    child: Text(t, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, color: selected ? AppColors.textInverse : AppColors.textSecondary)),
                  ),
                ));
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.s4),
            const Text('City *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.s2),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              dropdownColor: AppColors.bgTertiary,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(),
              hint: const Text('Select your city', style: TextStyle(color: AppColors.textTertiary)),
              items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _selectedCity = v),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
