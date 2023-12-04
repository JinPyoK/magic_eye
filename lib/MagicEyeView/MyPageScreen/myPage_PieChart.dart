import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

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
        double numOfOccupy = 0;
        double numOfTheft = 0;
        double numOfBreak = 0;
        for (var i = 0; i < recordData.length; i++) {
          if (recordData[i]['type'] == 'occupy') {
            numOfOccupy++;
          } else if (recordData[i]['type'] == 'theft') {
            numOfTheft++;
          } else if (recordData[i]['type'] == 'break') {
            numOfBreak++;
          }
        }
        Map<String, double> dataMap = {
          "점거": numOfOccupy,
          "도난": numOfTheft,
          "파손": numOfBreak,
        };
        return SizedBox(
          width: widget.width / 1.2,
          height: widget.height / 3.4,
          child: PieChart(
            chartRadius: widget.width / 2.5,
            dataMap: dataMap,
            chartLegendSpacing: 78,
            chartType: ChartType.ring,
            ringStrokeWidth: 48,
            centerWidget: const Text(
              "영상 통계",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            colorList: const [Colors.blue, Colors.yellow, Colors.red],
            chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: true,
                decimalPlaces: 0,
                chartValueBackgroundColor: Colors.white,
                chartValueStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
        );
      },
    );
  }
}
