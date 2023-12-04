import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'record_item.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';

class RecordList extends StatefulWidget {
  final double width;
  final double height;

  const RecordList(this.width, this.height, {super.key});

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      List<dynamic> recordData = context.watch<MainProvider>().records;
      return Container(
          width: widget.width / 1.2,
          height: widget.height / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0x207C72EC),
          ),
          child: context.watch<MainProvider>().refresh
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : (recordData.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.separated(
                        itemCount: recordData.length,
                        itemBuilder: (context, index) {
                          return RecordItem(
                              date: recordData[index]['date'] ?? '',
                              cam: recordData[index]['cam'] ?? '',
                              type: recordData[index]['type'] ?? '',
                              videoURL: recordData[index]['videoURL'] ?? '');
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        "이상 행동 데이터가 없습니다",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )));
    });
  }
}
