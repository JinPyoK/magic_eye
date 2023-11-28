import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';

class Intro extends StatefulWidget {
  final BuildContext context;

  const Intro(this.context, {super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          opacity = 1;
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (isLogin() && isEmailVerified()) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/MagicEyeView/NaviScreen', (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/HomeScreen', (route) => false);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png'),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "MagicEye",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const Text(
                  "안전한 매장관리의 첫걸음",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
