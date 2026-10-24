import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/onboarding_screen.dart';

void main() => runApp(const LostFoundApp());

class LostFoundApp extends StatelessWidget {
  const LostFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost & Found @ CUI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const OnboardingScreen(

      ),
    );
  }
}