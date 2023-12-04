import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';

class MyPageUserInfo extends StatefulWidget {
  final double width;
  final double height;

  const MyPageUserInfo(this.width, this.height, {super.key});

  @override
  State<MyPageUserInfo> createState() => _MyPageUserInfoState();
}

class _MyPageUserInfoState extends State<MyPageUserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 1.2,
      height: widget.height / 2.5,
      decoration: BoxDecoration(
        color: const Color(0x207C72EC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: widget.height / 40,
            ),
            renderUserName(widget.width),
            const SizedBox(
              height: 20,
            ),
            renderRowWith('계정생성일', Text(getCreationTime())),
            const SizedBox(
              height: 10,
            ),
            renderRowWith('이메일', Text(getEmail())),
            const SizedBox(
              height: 10,
            ),
            renderRowWith('등록 카메라 수',
                Text(context.watch<MainProvider>().cctvs.length.toString())),
          ],
        ),
      ),
    );
  }
}

renderUserName(double width) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: width / 2,
        child: Text(
          getDisplayName(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          overflow: TextOverflow.ellipsis,
        ),
      )
    ],
  );
}

renderRowWith(String key, Widget value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        value,
      ],
    ),
  );
}
