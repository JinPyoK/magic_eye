import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/MyPageScreen/temp_button.dart';

class MyPageSetting extends StatefulWidget {
  const MyPageSetting({super.key});

  @override
  State<MyPageSetting> createState() => _MyPageSettingState();
}

class _MyPageSettingState extends State<MyPageSetting> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TempButtons(),
      ),
    );
  }
}
