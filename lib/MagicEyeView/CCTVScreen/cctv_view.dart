import 'package:flutter/material.dart';

class CCTVView extends StatelessWidget {
  final double width;
  final double height;

  const CCTVView(this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 1.3,
      height: height / 2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
        ),
      ),
      child: const Center(child: Text("이곳에 실시간 영상 송출")),
    );
  }
}
