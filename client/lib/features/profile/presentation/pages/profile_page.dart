import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s4),
              child: Column(
                children: [
                  _buildStatsRow(),
                  const SizedBox(height: AppSpacing.s6),
                  _buildSection('Account', [
                    _MenuItem(icon: Icons.person_outline, label: 'Edit Profile', onTap: () {}),
                    _MenuItem(icon: Icons.favorite_outline, label: 'Favorites', onTap: () => context.push('/favorites')),
                    _MenuItem(icon: Icons.list_alt_outlined, label: 'My Listings', onTap: () {}),
                    _MenuItem(icon: Icons.local_offer_outlined, label: 'My Offers', onTap: () {}),
                    _MenuItem(icon: Icons.notifications_outlined, label: 'Notifications', onTap: () {}),
                  ]),
                  const SizedBox(height: AppSpacing.s4),
                  _buildSection('Settings', [
                    _MenuItem(icon: Icons.language_outlined, label: 'Language', trailing: 'English', onTap: () {}),
                    _MenuItem(icon: Icons.security_outlined, label: 'Security & Privacy', onTap: () {}),
                    _MenuItem(icon: Icons.help_outline, label: 'Help & Support', onTap: () {}),
                    _MenuItem(icon: Icons.info_outline, label: 'About EthioDrive', onTap: () {}),
                  ]),
                  const SizedBox(height: AppSpacing.s4),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, size: 18),
                      label: const Text('Sign Out'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(AppSpacing.s4, 60, AppSpacing.s4, AppSpacing.s6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.bgSecondary, AppColors.bgPrimary], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 44, backgroundColor: AppColors.goldPrimary,
                  child: const Text('A', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: AppColors.textInverse)),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    width: 28, height: 28,
                    decoration: const BoxDecoration(color: AppColors.bgSecondary, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, size: 16, color: AppColors.goldPrimary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s3),
            const Text('Abebe Kebede', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            const Text('+251 91 234 5678', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.s2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.goldShimmer,
                borderRadius: BorderRadius.circular(AppRadius.full),
                border: Border.all(color: AppColors.borderActive),
              ),
              child: const Text('Individual Seller', style: TextStyle(fontSize: 12, color: AppColors.goldPrimary, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _statCard('12', 'Listings'),
        const SizedBox(width: AppSpacing.s3),
        _statCard('45', 'Favorites'),
        const SizedBox(width: AppSpacing.s3),
        _statCard('4.8★', 'Rating'),
      ],
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s4),
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.goldPrimary)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 0.5)),
        const SizedBox(height: AppSpacing.s2),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgSecondary,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final isLast = e.key == items.length - 1;
              return Column(
                children: [
                  InkWell(
                    onTap: e.value.onTap,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s4),
                      child: Row(
                        children: [
                          Icon(e.value.icon, size: 20, color: AppColors.textSecondary),
                          const SizedBox(width: AppSpacing.s3),
                          Expanded(child: Text(e.value.label, style: const TextStyle(fontSize: 15, color: AppColors.textPrimary))),
                          if (e.value.trailing != null)
                            Text(e.value.trailing!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right, size: 18, color: AppColors.textTertiary),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast) Divider(height: 1, indent: AppSpacing.s10 + AppSpacing.s3, color: AppColors.borderSubtle),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String? trailing;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.label, this.trailing, required this.onTap});
}
