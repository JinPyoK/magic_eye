import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/database.dart';
import 'package:magic_eye/MagicEyeView/CCTVScreen/cctv_provider.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {}, child: const Text("값 출력")),
          ],
        ),
      ),
    );
  }
}
