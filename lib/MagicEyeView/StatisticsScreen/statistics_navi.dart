import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/StatisticsScreen/statistics_bar_chart.dart';
import 'package:magic_eye/MagicEyeView/StatisticsScreen/statistics_line_chart.dart';
import 'package:magic_eye/MagicEyeView/StatisticsScreen/statistics_pie_chart.dart';

class StatisticsNavi extends StatefulWidget {
  final double width;
  final double height;

  const StatisticsNavi(this.width, this.height, {super.key});

  @override
  State<StatisticsNavi> createState() => _StatisticsNaviState();
}

class _StatisticsNaviState extends State<StatisticsNavi> {
  final List<Widget> statistics = <Widget>[
    const Text('Record'),
    const Text('Age/Gender'),
    const Text('Visitors')
  ];
  final List<bool> _selectedStatistics = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 1.2,
      decoration: BoxDecoration(
        color: const Color(0x207C72EC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedStatistics.length; i++) {
                    _selectedStatistics[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.black87,
              borderWidth: 2.5,
              selectedColor: Colors.white,
              fillColor: Colors.black26,
              color: Colors.black54,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              isSelected: _selectedStatistics,
              children: statistics,
            ),
            const SizedBox(
              height: 10,
            ),
            Builder(builder: (_) {
              if (_selectedStatistics[0]) {
                return StatisticsPieChart(context, widget.width, widget.height);
              } else if (_selectedStatistics[1]) {
                return StatisticsBarChart(context, widget.width, widget.height);
              } else if (_selectedStatistics[2]) {
                return StatisticsLineChart(
                    context, widget.width, widget.height);
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
