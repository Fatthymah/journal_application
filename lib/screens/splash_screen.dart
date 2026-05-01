import 'dart:async';
import 'package:flutter/material.dart';
import 'package:journal_application/app_constants/colors.dart';
import 'package:journal_application/app_constants/texts.dart';
import 'package:provider/provider.dart';
import '../auth/controller/auth_provider.dart';
import '../auth/view/login_screen.dart';
import '../main.dart';
import 'nav_bar.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateToNext();
  }

  void navigateToNext() {
    Future.delayed(const Duration(seconds: 2), () {

      final auth = Provider.of<AuthProvider>(context, listen: false);

      // First time - Onboarding
      if (isFirstTime) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }

      // Already logged in - NavBar
      else if (auth.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NavBar()),
        );
      }

      // Not logged in - Login
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Icon
            Icon(
              Icons.menu_book_rounded,
              size: 90,
              color: AppColors.primary,
            ),

            const SizedBox(height: 20),

            // App Name
            Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            //Tagline
            Text(
              AppStrings.tagLine,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}