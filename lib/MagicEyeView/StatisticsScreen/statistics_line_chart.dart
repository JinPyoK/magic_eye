import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';

class StatisticsLineChart extends StatefulWidget {
  final BuildContext context;
  final double width;
  final double height;

  const StatisticsLineChart(this.context, this.width, this.height, {super.key});

  @override
  State<StatisticsLineChart> createState() => _StatisticsLineChartState();
}

class _StatisticsLineChartState extends State<StatisticsLineChart> {
  String showChart = 'M';

  late DateTime now;
  late List<int> numOfMonth;
  late List<int> numOfDay;
  late List<int> numOfHour;
  late List<int> numOfYear;

  List<FlSpot> emptySpots = const [
    FlSpot(0, 10),
    FlSpot(1, 10),
    FlSpot(2, 10),
    FlSpot(3, 10),
    FlSpot(4, 10),
    FlSpot(5, 10),
    FlSpot(6, 10),
    FlSpot(7, 10),
    FlSpot(8, 10),
    FlSpot(9, 10),
    FlSpot(10, 10),
    FlSpot(11, 10),
  ];

  List<FlSpot> monthSpots = [
    // FlSpot(0, 7.89),
    // FlSpot(1, 3.87),
    // FlSpot(2, 2.89),
    // FlSpot(3, 6.72),
    // FlSpot(4, 8.89),
    // FlSpot(5, 1.2),
    // FlSpot(6, 8.74),
    // FlSpot(7, 5.51),
    // FlSpot(8, 6.45),
    // FlSpot(9, 1.23),
    // FlSpot(10, 2.54),
    // FlSpot(11, 3.33),
  ];

  late List<FlSpot> animatedSpots;

  List<FlSpot> daySpots = [
    // FlSpot(0, 6),
    // FlSpot(2, 10),
    // FlSpot(4, 20),
    // FlSpot(7, 35),
    // FlSpot(8, 24),
    // FlSpot(9, 13),
    // FlSpot(11, 24),
    // FlSpot(12, 25),
  ];

  List<FlSpot> hourSpots = [
    // FlSpot(0, 3),
    // FlSpot(2, 1),
    // FlSpot(4, 5),
    // FlSpot(6, 1),
    // FlSpot(8, 4),
    // FlSpot(9, 1),
    // FlSpot(11, 8),
    // FlSpot(12, 2),
    // FlSpot(14, 1),
    // FlSpot(16, 2),
    // FlSpot(17, 6),
    // FlSpot(18, 4),
    // FlSpot(19, 13),
    // FlSpot(23, 8),
  ];

  List<FlSpot> yearSpots = [
    // FlSpot(0, 17),
    // FlSpot(1, 23),
    // FlSpot(2, 36),
    // FlSpot(3, 26),
  ];

  @override
  void initState() {
    super.initState();
    animatedSpots = emptySpots;

    MainProvider prov = widget.context.read<MainProvider>();
    now = prov.now;
    numOfMonth = prov.monthNum;
    numOfDay = prov.dayNum;
    numOfHour = prov.hourNum;
    numOfYear = prov.yearNum;

    for (int i = 0; i < now.month; i++) {
      monthSpots.add(FlSpot(i.toDouble(), numOfMonth[i].toDouble() / 100));
    }
    for (int i = 0; i < now.day; i++) {
      daySpots.add(FlSpot(i.toDouble(), numOfDay[i].toDouble()));
    }
    for (int i = 0; i < now.hour; i++) {
      hourSpots.add(FlSpot(i.toDouble(), numOfHour[i].toDouble()));
    }
    for (int i = 0; i < 4; i++) {
      yearSpots.add(FlSpot(i.toDouble(), numOfYear[i].toDouble() / 1000));
    }

    setState(() {});

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        animatedSpots = monthSpots;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff31415E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: widget.width / 1.2,
                    height: widget.height / 3.5,
                    child: Builder(builder: (context) {
                      if (showChart == 'M') {
                        return LineChart(
                          mainData(animatedSpots, monthBottomTitleWidgets,
                              monthLeftTitleWidgets),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutSine,
                        );
                      } else if (showChart == 'D') {
                        return LineChart(
                          mainData(daySpots, dayBottomTitleWidgets,
                              dayLeftTitleWidgets),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutSine,
                        );
                      } else if (showChart == 'H') {
                        return LineChart(
                          mainData(hourSpots, hourBottomTitleWidgets,
                              hourLeftTitleWidgets),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutSine,
                        );
                      } else if (showChart == 'Y') {
                        return LineChart(
                          mainData(yearSpots, yearBottomTitleWidgets,
                              yearLeftTitleWidgets),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutSine,
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (showChart == 'M') {
                            showChart = 'D';
                          } else if (showChart == 'D') {
                            showChart = 'H';
                          } else if (showChart == 'H') {
                            showChart = 'Y';
                          } else if (showChart == 'Y') {
                            showChart = 'M';
                          }
                        });
                      },
                      child: Center(
                        child: Text(
                          showChart,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Builder(builder: (_) {
                const TextStyle style = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20);
                if (showChart == 'M') {
                  return const Text(
                    "Month",
                    style: style,
                  );
                } else if (showChart == 'D') {
                  return const Text(
                    "Day",
                    style: style,
                  );
                } else if (showChart == 'H') {
                  return const Text(
                    "Hour",
                    style: style,
                  );
                } else if (showChart == 'Y') {
                  return const Text(
                    "Year",
                    style: style,
                  );
                } else {
                  return Container();
                }
              }),
              const SizedBox(
                width: 30,
              )
            ],
          ),
        ]),
      ],
    );
  }
}

LineChartData mainData(List<FlSpot> showSpots, dynamic bottomTitleWidgets,
    dynamic leftTitleWidgets) {
  List<Color> gradientColors = <Color>[
    Colors.cyanAccent,
    Colors.blueAccent,
  ];
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      // horizontalInterval: 1,
      // verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Colors.white30,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Colors.white30,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 35,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: const Border.symmetric(
            vertical: BorderSide(color: Colors.white38))),
    minX: 0,
    maxX: null,
    minY: 0,
    maxY: null,
    lineBarsData: [
      LineChartBarData(
        spots: showSpots,
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ),
    ],
  );
}

Widget monthBottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('1', style: style);
      break;
    case 1:
      text = const Text('2', style: style);
      break;
    case 2:
      text = const Text('3', style: style);
      break;
    case 3:
      text = const Text('4', style: style);
      break;
    case 4:
      text = const Text('5', style: style);
      break;
    case 5:
      text = const Text('6', style: style);
      break;
    case 6:
      text = const Text('7', style: style);
      break;
    case 7:
      text = const Text('8', style: style);
      break;
    case 8:
      text = const Text('9', style: style);
      break;
    case 9:
      text = const Text('10', style: style);
      break;
    case 10:
      text = const Text('11', style: style);
      break;
    case 11:
      text = const Text('12', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

// 100으로 나눈 값
Widget monthLeftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white70);
  String text;
  switch (value.toInt()) {
    case 1:
      text = '100';
      break;
    case 3:
      text = '300';
      break;
    case 6:
      text = '600';
      break;
    case 10:
      text = '1K';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

Widget dayBottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('1', style: style);
      break;
    case 4:
      text = const Text('5', style: style);
      break;
    case 9:
      text = const Text('10', style: style);
      break;
    case 19:
      text = const Text('20', style: style);
      break;
    case 29:
      text = const Text('30', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget dayLeftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white70);
  String text;
  switch (value.toInt()) {
    case 10:
      text = '10';
      break;
    case 20:
      text = '20';
      break;
    case 30:
      text = '30';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

Widget hourBottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('0', style: style);
      break;
    case 4:
      text = const Text('4', style: style);
      break;
    case 8:
      text = const Text('8', style: style);
      break;
    case 12:
      text = const Text('12', style: style);
      break;
    case 16:
      text = const Text('16', style: style);
      break;
    case 20:
      text = const Text('20', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget hourLeftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white70);
  String text;
  switch (value.toInt()) {
    case 1:
      text = '1';
      break;
    case 3:
      text = '3';
      break;
    case 6:
      text = '6';
      break;
    case 10:
      text = '10';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

// 지난 4년간 통계
Widget yearBottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70);
  DateTime now = DateTime.now();
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text((now.year - 3).toString(), style: style);
      break;
    case 1:
      text = Text((now.year - 2).toString(), style: style);
      break;
    case 2:
      text = Text((now.year - 1).toString(), style: style);
      break;
    case 3:
      text = Transform.translate(
        offset: const Offset(-12, 0),
        child: Text(
          now.year.toString(),
          style: style,
        ),
      );
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

// 1000으로 나눈 값
Widget yearLeftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white70);
  String text;
  switch (value.toInt()) {
    case 5:
      text = '5K';
      break;
    case 10:
      text = '10K';
      break;
    case 20:
      text = '20K';
      break;
    case 35:
      text = '35K';
      break;
    case 50:
      text = '50K';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
