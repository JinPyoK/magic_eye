import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';
import 'package:magic_eye/Login/signin.dart';
import 'package:magic_eye/Login/email_verify.dart';
import 'package:magic_eye/Login/signup.dart';
import 'package:magic_eye/Login/reset_password.dart';
import 'package:magic_eye/IntroScreen/home_screen.dart';
import 'navi.dart';

class NaviScreen extends StatelessWidget {
  const NaviScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/HomeScreen': (context) => const HomeScreen(),
            '/Login/SignIn': (context) => const SignIn(),
            '/Login/SignUp': (context) => const SignUp(),
            '/Login/EmailVerify': (context) => const EmailVerify(),
            '/Login/ResetPassword': (context) => const ResetPassword(),
            '/MagicEyeView/NaviScreen': (context) => const NaviScreen(),
          },
          home: const Navi()),
    );
  }
}
