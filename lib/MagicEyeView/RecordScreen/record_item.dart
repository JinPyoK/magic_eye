import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_provider.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_video.dart';
import 'package:provider/provider.dart';

class RecordItem extends StatefulWidget {
  final String date;
  final String cam;
  final String type;
  final String videoURL;

  const RecordItem(
      {super.key,
      required this.date,
      required this.cam,
      required this.type,
      required this.videoURL});

  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  TextStyle style = const TextStyle(fontWeight: FontWeight.bold);
  late ExpansionTileController _controller;
  bool expansionOn = false;

  @override
  void initState() {
    super.initState();
    _controller = ExpansionTileController();
  }

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
                controller: _controller,
                title: renderTitle(width, widget.type, widget.cam, style),
                subtitle: renderSubTitle(width, widget.date, widget.cam, style),
                trailing: expansionOn
                    ? renderDeleteButton(context, widget.date, widget.cam,
                        widget.type, widget.videoURL, _controller)
                    : const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                onExpansionChanged: (val) {
                  setState(() {
                    expansionOn = val;
                  });
                },
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

renderTitle(double width, String type, String cam, TextStyle style) {
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
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        typeString,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

renderSubTitle(double width, String date, String cam, TextStyle style) {
  return Row(
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(minWidth: 0, maxWidth: width / 6),
        child: Text(
          cam,
          style: style,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Text(
        date,
        style: style,
      ),
    ],
  );
}

renderDeleteButton(BuildContext context, String date, String cam, String type,
    String videoURL, ExpansionTileController controller) {
  late String typeString;
  if (type == 'occupy') {
    typeString = '점거';
  } else if (type == 'theft') {
    typeString = '도난';
  } else if (type == 'break') {
    typeString = '파손';
  }
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              content: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "정말 삭제하시겠습니까?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      typeString,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      cam,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      date,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "취소",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        context
                            .read<RecordProvider>()
                            .deleteData(date, cam, type, videoURL);
                        context.read<RecordProvider>().dataCollapse(controller);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "삭제",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            );
          });
    },
    child: const Icon(
      Icons.delete_forever_outlined,
      color: Colors.grey,
    ),
  );
}
