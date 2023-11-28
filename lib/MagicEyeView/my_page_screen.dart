import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, "/Login/SignIn", (route) => false);
    }

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await signOut();
                  navFunction();
                },
                child: const Text("로그아웃")),
          ],
        ),
      ),
    );
  }
}
