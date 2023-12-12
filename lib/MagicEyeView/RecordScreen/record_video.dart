import 'package:flutter/material.dart';

class RecordVideo extends StatefulWidget {
  final double width;
  final String videoURL;

  const RecordVideo(this.width, this.videoURL, {super.key});

  @override
  State<RecordVideo> createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 1.1,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
    );
  }
}
