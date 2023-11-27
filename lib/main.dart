import 'package:flutter/material.dart';
import 'package:magic_eye/Login/email_verify.dart';
import 'package:magic_eye/Login/reset_password.dart';
import 'home_screen.dart';
import 'Login/signin.dart';
import 'Login/signup.dart';
import 'MagicEyeView/navi_screen.dart';
import 'package:magic_eye/Firebase/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/Login/LoginMain' : (context) => const SignIn(),
        '/Login/SignUp' : (context) => const SignUp(),
        '/Login/EmailVerify' : (context) => const EmailVerify(),
        '/Login/ResetPassword' : (context) => const ResetPassword(),
        '/MagicEyeView/NaviScreen' : (context) => const NaviScreen(),
      },
      home: isLogin() && isEmailVerified() ? const NaviScreen() : const HomeScreen(),
    );
  }
}
