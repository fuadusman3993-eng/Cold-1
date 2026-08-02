import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.s10),
              // Logo
              Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
                    child: const Icon(Icons.directions_car, color: AppColors.textInverse, size: 26),
                  ),
                  const SizedBox(width: 12),
                  const Text('EthioDrive', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.goldPrimary)),
                ],
              ),
              const SizedBox(height: AppSpacing.s8),
              const Text('Welcome Back', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: AppSpacing.s2),
              const Text('Sign in to your account to continue', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
              const SizedBox(height: AppSpacing.s8),
              const Text('Phone Number', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              const SizedBox(height: AppSpacing.s2),
              TextField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                decoration: const InputDecoration(
                  prefixText: '+251  ',
                  prefixStyle: TextStyle(color: AppColors.textPrimary, fontSize: 16),
                  hintText: '9XX XXX XXXX',
                ),
              ),
              const SizedBox(height: AppSpacing.s6),
              ElevatedButton(
                onPressed: _isLoading ? null : _onLogin,
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textInverse))
                    : const Text('Send OTP'),
              ),
              const SizedBox(height: AppSpacing.s6),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.borderSubtle)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: AppSpacing.s4), child: Text('or', style: TextStyle(color: AppColors.textTertiary))),
                  Expanded(child: Divider(color: AppColors.borderSubtle)),
                ],
              ),
              const SizedBox(height: AppSpacing.s6),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: const Text('Continue with Google'),
              ),
              const SizedBox(height: AppSpacing.s3),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.apple, size: 22),
                label: const Text('Continue with Apple'),
              ),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Don\'t have an account? Sign up', style: TextStyle(color: AppColors.goldPrimary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if (_phoneCtrl.text.isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) context.push('/otp', extra: _phoneCtrl.text);
  }
}
