import 'package:demoapp/login.dart';
import 'package:demoapp/mainpage/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          }
        },
      );

    _startAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.duration = const Duration(milliseconds: 2000);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Container(
              alignment: Alignment.center,
              child: LottieBuilder.asset(
                'assets/raw/hi.json',
                width: 300,
                reverse: false,
                repeat: false,
                controller: _animationController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
