import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';

class StatisticsBarChart extends StatefulWidget {
  final BuildContext context;
  final double width;
  final double height;

  const StatisticsBarChart(this.context, this.width, this.height, {super.key});

  @override
  State<StatisticsBarChart> createState() => _StatisticsBarChartState();
}

class _StatisticsBarChartState extends State<StatisticsBarChart> {
  int numOfMan1 = 0;
  int numOfWoman1 = 0;
  int numOfMan2 = 0;
  int numOfWoman2 = 0;
  int numOfMan3 = 0;
  int numOfWoman3 = 0;
  int numOfMan4 = 0;
  int numOfWoman4 = 0;

  int totalOfMan = 0;
  int totalOfWoman = 0;

  double val1 = 0;
  double val2 = 0;
  double val3 = 0;
  double val4 = 0;
  double val5 = 0;
  double val6 = 0;
  double val7 = 0;
  double val8 = 0;

  @override
  void initState() {
    super.initState();
    Map<dynamic, dynamic> peopleInfo =
        widget.context.read<MainProvider>().userInfo.peopleInfo;

    for (var info in peopleInfo.values) {
      int age = info['age'].toInt();
      String gender = info['gender'];

      if (age < 20 && gender == 'Man') {
        numOfMan1++;
      } else if (age < 20 && gender == 'Woman') {
        numOfWoman1++;
      } else if ((age >= 20 && age < 40) && gender == 'Man') {
        numOfMan2++;
      } else if ((age >= 20 && age < 40) && gender == 'Woman') {
        numOfWoman2++;
      } else if ((age >= 40 && age < 60) && gender == 'Man') {
        numOfMan3++;
      } else if ((age >= 40 && age < 60) && gender == 'Woman') {
        numOfWoman3++;
      } else if (age > 60 && gender == 'Man') {
        numOfMan4++;
      } else if (age > 60 && gender == 'Woman') {
        numOfWoman4++;
      }
    }
    totalOfMan = numOfMan1 + numOfMan2 + numOfMan3 + numOfMan4;
    totalOfWoman = numOfWoman1 + numOfWoman2 + numOfWoman3 + numOfWoman4;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        val1 = numOfMan1 / totalOfMan * 100;
        val2 = numOfWoman1 / totalOfWoman * 100;
        val3 = numOfMan2 / totalOfMan * 100;
        val4 = numOfWoman2 / totalOfWoman * 100;
        val5 = numOfMan3 / totalOfMan * 100;
        val6 = numOfWoman3 / totalOfWoman * 100;
        val7 = numOfMan4 / totalOfMan * 100;
        val8 = numOfWoman4 / totalOfWoman * 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff31415E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: widget.width / 1.2,
                  height: widget.height / 3.5,
                  child: BarChart(
                    BarChartData(
                      maxY: 100,
                      titlesData: const FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 42,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      gridData: const FlGridData(show: false),
                      backgroundColor: const Color(0xff31415E),
                      barGroups: renderBarGroups(<double>[
                        val1,
                        val2,
                        val3,
                        val4,
                        val5,
                        val6,
                        val7,
                        val8
                      ]),
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 400),
                    // Optional
                    swapAnimationCurve: Curves.easeOutSine, // Optional
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        renderDataTable(<int>[
          numOfMan1,
          numOfWoman1,
          numOfMan2,
          numOfWoman2,
          numOfMan3,
          numOfWoman3,
          numOfMan4,
          numOfWoman4
        ])
      ],
    );
  }
}

renderBarGroups(List<double> percent) {
  return <BarChartGroupData>[
    renderBarChartGroupData(0, percent[0], percent[1]),
    renderBarChartGroupData(1, percent[2], percent[3]),
    renderBarChartGroupData(2, percent[4], percent[5]),
    renderBarChartGroupData(3, percent[6], percent[7]),
  ];
}

renderBarChartGroupData(int x, double manY, double womanY) {
  return BarChartGroupData(
    x: x,
    barsSpace: 10,
    barRods: <BarChartRodData>[
      BarChartRodData(toY: manY, width: 12, color: Colors.lightBlueAccent),
      BarChartRodData(toY: womanY, width: 12, color: Colors.redAccent),
    ],
  );
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 0) {
    text = '0';
  } else if (value == 30) {
    text = '30%';
  } else if (value == 60) {
    text = '60%';
  } else if (value == 90) {
    text = '90%';
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
  final titles = <String>['0~19', '20~39', '40~59', '60~'];

  final Widget text = Text(
    titles[value.toInt()],
    style: const TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16, //margin top
    child: text,
  );
}

renderDataTable(List<int> info) {
  TextStyle style = const TextStyle(fontWeight: FontWeight.bold);
  return DataTable(
      border: const TableBorder(
          top: BorderSide(width: 2, color: Colors.black38),
          bottom: BorderSide(width: 2, color: Colors.black38),
          verticalInside: BorderSide(width: 1, color: Colors.black26)),
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            '연령/성별',
            style: style,
          ),
        ),
        DataColumn(
          label: Text(
            '남자',
            style: style,
          ),
        ),
        DataColumn(
          label: Text(
            '여자',
            style: style,
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Center(
                child: Text(
              '0~19',
              style: style,
            ))),
            DataCell(Center(child: Text(info[0].toString()))),
            DataCell(Center(child: Text(info[1].toString()))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Center(
                child: Text(
              '20~39',
              style: style,
            ))),
            DataCell(Center(child: Text(info[2].toString()))),
            DataCell(Center(child: Text(info[3].toString()))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Center(
                child: Text(
              '40~59',
              style: style,
            ))),
            DataCell(Center(child: Text(info[4].toString()))),
            DataCell(Center(child: Text(info[5].toString()))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Center(
                child: Text(
              '60~',
              style: style,
            ))),
            DataCell(Center(child: Text(info[6].toString()))),
            DataCell(Center(child: Text(info[7].toString()))),
          ],
        ),
      ]);
}
