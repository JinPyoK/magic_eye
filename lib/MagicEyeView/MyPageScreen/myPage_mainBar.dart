import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/MyPageScreen/myPage_setting.dart';

class MyPageMainBar extends StatelessWidget {
  final double width;

  const MyPageMainBar(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width / 1.6,
          child: const Text(
            "사용자 정보",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff7C72EC),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MyPageSetting()));
            },
            child: const Icon(
              Icons.settings,
              color: Colors.white,
            ))
      ],
    );
  }
}
