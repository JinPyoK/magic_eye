import 'package:flutter/material.dart';
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
    const Text('Age'),
    const Text('People')
  ];
  final List<bool> _selectedStatistics = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 1.2,
      height: widget.height / 1.5,
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
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              isSelected: _selectedStatistics,
              children: statistics,
            ),
            const SizedBox(
              height: 20,
            ),
            Builder(builder: (_) {
              if (_selectedStatistics[0]) {
                return StatisticsPieChart(widget.width, widget.height);
              } else if (_selectedStatistics[1]) {
                return const Text("1번째");
              } else if (_selectedStatistics[2]) {
                return const Text("2번째");
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
