import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_video.dart';

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
  TextStyle style = const TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: LayoutBuilder(
          builder: (_, box) {
            final width = box.maxWidth;
            return Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: renderTitle(widget.type, style),
                subtitle: Text(
                  widget.date,
                  style: style,
                ),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  RecordVideo(width, widget.videoURL),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

renderTitle(String type, TextStyle style) {
  late String typeString;
  late Color color;

  if (type == "occupy") {
    typeString = "점거";
    color = Colors.lightBlueAccent;
  } else if (type == 'theft') {
    typeString = '도난';
    color = Colors.yellowAccent;
  } else if (type == 'break') {
    typeString = '파손';
    color = Colors.redAccent;
  } else {
    typeString = '알 수 없음';
    color = Colors.black38;
  }

  return Row(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        typeString,
        style: style,
      ),
    ],
  );
}
