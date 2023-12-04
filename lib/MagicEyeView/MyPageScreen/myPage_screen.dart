import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/MyPageScreen/myPage_mainBar.dart';
import 'package:magic_eye/MagicEyeView/MyPageScreen/myPage_userInfo.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: LayoutBuilder(
        builder: (_, box) {
          final width = box.maxWidth;
          final height = box.maxHeight;
          return Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height / 25,
                    ),
                    MyPageMainBar(width),
                    SizedBox(
                      height: height / 25,
                    ),
                    MyPageUserInfo(width, height)
                  ],
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
