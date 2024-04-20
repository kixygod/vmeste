import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:VMeste/ui/navigation/main_navigation.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Mixin added here
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000)); // Initialize controller with vsync
    _checkToken();
  }

  Future<void> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Wait for the animation to complete before navigating
    await _animationController.forward();
    if (token != null && token.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(RouteNames.homeView);
    } else {
      Navigator.of(context).pushReplacementNamed(RouteNames.authView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // Ширина экрана
          height: MediaQuery.of(context).size.height, // Высота экрана
          child: Lottie.asset(
            'assets/splash_screen_animation.json',
            controller: _animationController,
            fit: BoxFit.cover, // Заполняет выделенное пространство, сохраняя пропорции
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
