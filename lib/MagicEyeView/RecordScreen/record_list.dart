import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'record_item.dart';
import 'record_provider.dart';

class RecordList extends StatelessWidget {
  final double width;
  final double height;

  const RecordList(this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      List<dynamic> recordData = context.watch<RecordProvider>().records;
      return Container(
        width: width / 1.2,
        height: height / 1.4,
        decoration: BoxDecoration(border: Border.all()),
        child: ListView.builder(
            itemCount: recordData.length,
            itemBuilder: (context, index) {
              return RecordItem(
                  date: recordData[index]['date'] ?? '',
                  type: recordData[index]['type'] ?? '',
                  videoURL: recordData[index]['videoURL'] ?? '');
            }),
      );
    });
  }
}
