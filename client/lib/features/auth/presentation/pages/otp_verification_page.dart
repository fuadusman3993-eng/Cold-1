import 'package:flutter/material.dart';
import '../../data/auth_api.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phone;
  const OtpVerificationPage({super.key, required this.phone});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final AuthApi _authApi = AuthApi();
  bool _isLoading = false;

  void _verifyOtp() async {
    setState(() => _isLoading = true);
    // Use 123456 as the mock OTP from our backend setup
    final success = await _authApi.login(widget.phone, _otpController.text);
    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!'), backgroundColor: Colors.green),
      );
      // We would navigate to the Home Page here
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Use 123456.'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the code sent to ${widget.phone}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'OTP Code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Verify & Login', style: TextStyle(color: Colors.black)),
                  ),
          ],
        ),
      ),
    );
  }
}
