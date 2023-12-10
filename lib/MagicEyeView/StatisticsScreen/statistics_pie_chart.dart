import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPieChart extends StatefulWidget {
  final BuildContext context;
  final double width;
  final double height;

  const StatisticsPieChart(this.context, this.width, this.height, {super.key});

  @override
  State<StatisticsPieChart> createState() => _StatisticsPieChartState();
}

class _StatisticsPieChartState extends State<StatisticsPieChart> {
  int numOfOccupy = 1;
  int numOfTheft = 1;
  int numOfBreak = 1;

  double opacity = 0;

  @override
  void initState() {
    super.initState();
    List<dynamic> recordData = widget.context.read<MainProvider>().records;

    if (recordData.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          for (var i = 0; i < recordData.length; i++) {
            if (recordData[i]['type'] == 'occupy') {
              numOfOccupy++;
            } else if (recordData[i]['type'] == 'theft') {
              numOfTheft++;
            } else if (recordData[i]['type'] == 'break') {
              numOfBreak++;
            }
          }
          numOfOccupy--;
          numOfTheft--;
          numOfBreak--;
        });
      });
    } else {
      numOfOccupy = 0;
      numOfTheft = 0;
      numOfBreak = 0;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            SizedBox(
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
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutSine,
              child: renderDataTable(numOfOccupy, numOfTheft, numOfBreak),
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutSine,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "총합: ${numOfOccupy + numOfTheft + numOfBreak}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

renderPieChart(double width, int numOfOccupy, int numOfTheft, int numOfBreak) {
  TextStyle style = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  double radius = width / 4;
  int total = numOfOccupy + numOfTheft + numOfBreak;
  String percentOfOccupy = (numOfOccupy / total * 100).toStringAsFixed(1);
  String percentOfTheft = (numOfTheft / total * 100).toStringAsFixed(1);
  String percentOfBreak = (numOfBreak / total * 100).toStringAsFixed(1);
  return PieChart(
    PieChartData(sectionsSpace: 7, centerSpaceRadius: 0, sections: [
      PieChartSectionData(
          radius: radius,
          value: numOfOccupy.toDouble(),
          title: "$percentOfOccupy%",
          color: Colors.blue,
          titleStyle: style),
      PieChartSectionData(
          radius: radius,
          value: numOfTheft.toDouble(),
          title: "$percentOfTheft%",
          color: Colors.yellow,
          titleStyle: style),
      PieChartSectionData(
          radius: radius,
          value: numOfBreak.toDouble(),
          title: "$percentOfBreak%",
          color: Colors.red,
          titleStyle: style),
    ]),
    swapAnimationDuration: const Duration(milliseconds: 400), // Optional
    swapAnimationCurve: Curves.easeOutSine, // Optional
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

renderDataTable(int numOfOccupy, int numOfTheft, int numOfBreak) {
  return DataTable(
      border: const TableBorder(
          top: BorderSide(width: 2, color: Colors.black38),
          bottom: BorderSide(width: 2, color: Colors.black38),
          verticalInside: BorderSide(width: 1, color: Colors.black26)),
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              '  점거  ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              '  도난  ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              '  파손  ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Center(child: Text(numOfOccupy.toString()))),
            DataCell(Center(child: Text(numOfTheft.toString()))),
            DataCell(Center(child: Text(numOfBreak.toString()))),
          ],
        ),
      ]);
}
