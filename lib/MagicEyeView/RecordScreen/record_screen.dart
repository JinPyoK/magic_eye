import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_list.dart';
import 'package:provider/provider.dart';
import 'record_provider.dart';
import 'record_main_bar.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RecordProvider())],
      child: Scaffold(
        body: LayoutBuilder(
          builder: (_, box) {
            final width = box.maxWidth;
            final height = box.maxHeight;
            return Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: height / 25,
                      ),
                      RecordMainBar(width),
                      SizedBox(
                        height: height / 30,
                      ),
                      RecordList(width, height)
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
