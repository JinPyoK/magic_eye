import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
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
                  setState(() {
                    signOutLoading = true;
                  });

                  await signOut();
                  setState(() {
                    signOutLoading = false;
                  });
                  navFunction();
                },
                child: signOutLoading
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : const Text("로그아웃")),
            ElevatedButton(
                onPressed: () async {
                  confirm();
                },
                child: const Text("확인")),
          ],
        ),
      ),
    );
  }
}
