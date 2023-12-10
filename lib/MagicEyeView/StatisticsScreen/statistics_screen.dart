import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/StatisticsScreen/statistics_navi.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (_, box) {
        final width = box.maxWidth;
        final height = box.maxHeight;
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  renderMainBar(width),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(child: StatisticsNavi(context, width, height)),
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}

renderMainBar(double width) {
  return SizedBox(
    width: width / 1.3,
    child: const Text(
      '통계 분석',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    ),
  );
}
