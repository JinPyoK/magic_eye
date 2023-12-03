import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'record_provider.dart';

class RecordMainBar extends StatelessWidget {
  final double width;

  const RecordMainBar(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width / 1.6,
          child: const Text(
            "영상 기록",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff7C72EC),
            ),
            onPressed: () {
              context.read<RecordProvider>().refreshRecordData();
            },
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            ))
      ],
    );
  }
}
