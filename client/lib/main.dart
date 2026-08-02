import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const EthioDriveApp());
}

class EthioDriveApp extends StatelessWidget {
  const EthioDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EthioDrive',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0C10),
        primaryColor: const Color(0xFFD4AF37),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: const Color(0xFFF5F5F7),
          displayColor: const Color(0xFFF5F5F7),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFFE8D48B),
          surface: Color(0xFF121418),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
