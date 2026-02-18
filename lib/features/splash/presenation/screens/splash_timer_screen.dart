import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/routing/router.dart';

class SplashTimerScreen extends StatefulWidget {
  const SplashTimerScreen({super.key});

  @override
  State<SplashTimerScreen> createState() => _SplashTimerScreenState();
}

class _SplashTimerScreenState extends State<SplashTimerScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background_app.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ), 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/svg/logo_lavender2.svg",
                  width: 220,
                  height: 172,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _checkAuth() async {
    final accessToken = await SecureStorageHelper.getAccessToken();

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (accessToken != null && accessToken.isNotEmpty) {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onboardingScreen);
    }
  }
}
