import 'package:flutter/material.dart';

class RecordItem extends StatefulWidget {
  final String date;
  final String type;
  final String videoURL;

  const RecordItem(
      {super.key,
      required this.date,
      required this.type,
      required this.videoURL});

  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.date),
        Text(widget.type),
        Text(widget.videoURL),
      ],
    );
  }
}
