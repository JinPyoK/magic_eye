import 'package:flutter/material.dart';

class LineChartTable extends StatefulWidget {
  final String info1;
  final String info2;
  final String info3;
  final String info4;

  const LineChartTable(this.info1, this.info2, this.info3, this.info4,
      {super.key});

  @override
  State<LineChartTable> createState() => _LineChartTableState();
}

class _LineChartTableState extends State<LineChartTable> {
  TextStyle style = const TextStyle(fontWeight: FontWeight.bold);

  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutSine,
      child: DataTable(
          border: const TableBorder(
              top: BorderSide(width: 2, color: Colors.black38),
              bottom: BorderSide(width: 2, color: Colors.black38),
              verticalInside: BorderSide(width: 1, color: Colors.black26)),
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                '  Peak  ',
                style: style,
              ),
            ),
            DataColumn(
              label: Text(
                'Off-Peak',
                style: style,
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text(widget.info1))),
                DataCell(Center(child: Text(widget.info3))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text(widget.info2))),
                DataCell(Center(child: Text(widget.info4))),
              ],
            ),
          ]),
    );
  }
}
