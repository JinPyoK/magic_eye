import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChart extends StatelessWidget {
  final double width;
  final double height;

  const PieChart(this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width / 1.2,
        height: height / 3.4,
        decoration: BoxDecoration(border: Border.all()),
        child: Container());
  }
}

// https://github.com/imaNNeo/fl_chart/blob/master/repo_files/documentations/pie_chart.md
