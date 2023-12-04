import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class MyPagePieChart extends StatefulWidget {
  final double width;
  final double height;

  const MyPagePieChart(this.width, this.height, {super.key});

  @override
  State<MyPagePieChart> createState() => _MyPagePieChartState();
}

class _MyPagePieChartState extends State<MyPagePieChart> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        List<dynamic> recordData = context.watch<MainProvider>().records;
        int numOfOccupy = 0;
        int numOfTheft = 0;
        int numOfBreak = 0;
        for (var i = 0; i < recordData.length; i++) {
          if (recordData[i]['type'] == 'occupy') {
            numOfOccupy++;
          } else if (recordData[i]['type'] == 'theft') {
            numOfTheft++;
          } else if (recordData[i]['type'] == 'break') {
            numOfBreak++;
          }
        }
        return SizedBox(
          width: widget.width / 1.2,
          height: widget.height / 3.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: widget.width / 3,
                  height: widget.height / 4,
                  child: renderPieChart(
                      widget.width, numOfOccupy, numOfTheft, numOfBreak)),
              renderLegend(widget.width),
            ],
          ),
        );
      },
    );
  }
}

renderPieChart(double width, int numOfOccupy, int numOfTheft, int numOfBreak) {
  TextStyle style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: width / 15,
  );

  double radius = width / 4;
  return PieChart(
    PieChartData(sectionsSpace: 10, centerSpaceRadius: 0, sections: [
      PieChartSectionData(
          radius: radius,
          value: numOfOccupy.toDouble(),
          title: "$numOfOccupy",
          color: Colors.blue,
          titleStyle: style),
      PieChartSectionData(
          radius: radius,
          value: numOfTheft.toDouble(),
          title: "$numOfTheft",
          color: Colors.yellow,
          titleStyle: style),
      PieChartSectionData(
          radius: radius,
          value: numOfBreak.toDouble(),
          title: "$numOfBreak",
          color: Colors.red,
          titleStyle: style),
    ]),
    swapAnimationDuration: const Duration(milliseconds: 150), // Optional
    swapAnimationCurve: Curves.linear, // Optional
  );
}

renderLegend(double width) {
  TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  double size = width / 25;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Row(
        children: [
          Container(
            width: size,
            height: size,
            color: Colors.blue,
          ),
          Text(
            "  점거",
            style: style,
          ),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      Row(
        children: [
          Container(
            width: size,
            height: size,
            color: Colors.yellow,
          ),
          Text(
            "  도난",
            style: style,
          ),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      Row(
        children: [
          Container(
            width: size,
            height: size,
            color: Colors.red,
          ),
          Text(
            "  파손",
            style: style,
          ),
        ],
      ),
    ],
  );
}
