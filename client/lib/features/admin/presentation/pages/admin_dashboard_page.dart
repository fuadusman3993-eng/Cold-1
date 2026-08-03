import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(title: const Text('Admin Dashboard'), backgroundColor: AppColors.bgPrimary),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.s4),
            Row(
              children: [
                _buildStatCard('Total Users', '12,450', Icons.people_outline, AppColors.info),
                const SizedBox(width: AppSpacing.s3),
                _buildStatCard('Active Listings', '3,842', Icons.directions_car_outlined, AppColors.success),
              ],
            ),
            const SizedBox(height: AppSpacing.s3),
            Row(
              children: [
                _buildStatCard('Pending Review', '145', Icons.pending_actions, AppColors.warning),
                const SizedBox(width: AppSpacing.s3),
                _buildStatCard('Reports', '24', Icons.report_outlined, AppColors.error),
              ],
            ),
            const SizedBox(height: AppSpacing.s8),
            const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.s4),
            _buildActivityItem('New Listing Pending', '2022 Toyota RAV4 by Abebe K.', '10 mins ago'),
            _buildActivityItem('User Reported', 'Suspicious activity on listing #4829', '1 hr ago'),
            _buildActivityItem('Dealer Verified', 'Addis Auto Gallery approved', '3 hrs ago'),
            _buildActivityItem('System Alert', 'Database backup completed', '5 hrs ago'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s4),
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, size: 18, color: color),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s3),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s3),
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          children: [
            Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(color: AppColors.goldPrimary, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
          ],
        ),
      ),
    );
  }
}
