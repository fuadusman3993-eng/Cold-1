import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phone;
  const OtpVerificationPage({super.key, required this.phone});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpCtrl = TextEditingController();
  bool _isLoading = false;

  void _verifyOtp() async {
    if (_otpCtrl.text.length != 6) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(backgroundColor: AppColors.bgPrimary),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter OTP', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.s2),
            Text(
              'A 6-digit code was sent to +251${widget.phone}',
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.s8),
            TextField(
              controller: _otpCtrl,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: 12),
              decoration: const InputDecoration(
                hintText: '------',
                hintStyle: TextStyle(letterSpacing: 12, fontSize: 28, color: AppColors.textTertiary),
                counterText: '',
              ),
              onChanged: (v) { if (v.length == 6) _verifyOtp(); },
            ),
            const SizedBox(height: AppSpacing.s6),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyOtp,
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textInverse))
                  : const Text('Verify & Login'),
            ),
            const SizedBox(height: AppSpacing.s4),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('Resend OTP', style: TextStyle(color: AppColors.goldPrimary)),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            Container(
              padding: const EdgeInsets.all(AppSpacing.s4),
              decoration: BoxDecoration(color: AppColors.bgTertiary, borderRadius: BorderRadius.circular(AppRadius.md)),
              child: const Row(children: [
                Icon(Icons.info_outline, size: 16, color: AppColors.info),
                SizedBox(width: AppSpacing.s2),
                Expanded(child: Text('For testing, use OTP: 123456', style: TextStyle(fontSize: 12, color: AppColors.info))),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
