import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cctv_provider.dart';

class CCTVView extends StatefulWidget {
  final double width;
  final double height;

  const CCTVView(this.width, this.height, {super.key});

  @override
  State<CCTVView> createState() => _CCTVViewState();
}

class _CCTVViewState extends State<CCTVView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 1.3,
      height: widget.height / 2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
        ),
      ),
      child: StreamBuilder<int>(
        stream: context.watch<CCTVProvider>().fetchCCTV(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "오류 발생",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            );
          }
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data.toString()));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            return const Center(child: Text("이곳에 실시간 영상 송출"));
          }
        },
      ),
    );
  }
}
