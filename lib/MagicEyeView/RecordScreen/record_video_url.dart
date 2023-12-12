import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/storage.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_video.dart';

class RecordVideoURL extends StatefulWidget {
  final double width;
  final String videoName;

  const RecordVideoURL(this.width, this.videoName, {super.key});

  @override
  State<RecordVideoURL> createState() => _RecordVideoURLState();
}

class _RecordVideoURLState extends State<RecordVideoURL> {
  late Future<String> _url;

  @override
  void initState() {
    super.initState();
    _url = getStorageURL('example1.mp4');
    // _url = getStorageURL(widget.videoURL);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 1.1,
      height: 200,
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<String>(
          future: _url,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError || snapshot.data == 'error') {
              return const Center(
                child: Text("오류가 발생했습니다"),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("데이터가 존재하지 않습니다."),
              );
            } else {
              return RecordVideo(snapshot.data!);
            }
          }),
    );
  }
}
