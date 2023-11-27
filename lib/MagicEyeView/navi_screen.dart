import 'package:flutter/material.dart';
import '../Login/auth.dart';

class NaviScreen extends StatelessWidget {
  const NaviScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              await signOut();
            }, child: const Text("로그아웃")),
            const SizedBox(width: 100,),
            ElevatedButton(onPressed: () {
              confirm();
            }, child: const Text("상태")),
          ],
        ),
      ),
    );
  }
}
