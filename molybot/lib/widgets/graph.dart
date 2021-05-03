import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'line_titles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("historical_data")
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> tmp) {
          if (tmp.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("None"),
            );
          }
          final tmpDocs = tmp.data.docs;
          final test = tmpDocs[0];
          return LineChart(
            LineChartData(
              minX: 0,
              maxX: 1440,
              minY: 3000,
              //maxY: test.data()["max"],
              maxY: 3300,
              titlesData: LineTitles.getTitleData(),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: const Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: const Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, test.data()["0"]),
                    FlSpot(10, test.data()["1"]),
                    FlSpot(20, test.data()["2"]),
                    FlSpot(30, test.data()["3"]),
                    FlSpot(40, test.data()["4"]),
                    FlSpot(50, test.data()["5"]),
                    FlSpot(60, test.data()["6"]),
                    FlSpot(70, test.data()["7"]),
                    FlSpot(80, test.data()["8"]),
                    FlSpot(90, test.data()["9"]),
                    FlSpot(100, test.data()["10"]),
                    FlSpot(110, test.data()["11"]),
                    FlSpot(120, test.data()["12"]),
                    FlSpot(130, test.data()["13"]),
                    FlSpot(140, test.data()["14"]),
                    FlSpot(150, test.data()["15"]),
                    FlSpot(160, test.data()["16"]),
                    FlSpot(170, test.data()["17"]),
                    FlSpot(180, test.data()["18"]),
                    FlSpot(190, test.data()["19"]),
                    FlSpot(200, test.data()["20"]),
                    FlSpot(210, test.data()["21"]),
                    FlSpot(220, test.data()["22"]),
                    FlSpot(230, test.data()["23"]),
                    FlSpot(240, test.data()["24"]),
                    FlSpot(250, test.data()["25"]),
                    FlSpot(260, test.data()["26"]),
                    FlSpot(270, test.data()["27"]),
                    FlSpot(280, test.data()["28"]),
                    FlSpot(290, test.data()["29"]),
                    FlSpot(300, test.data()["30"]),
                    FlSpot(310, test.data()["31"]),
                    FlSpot(320, test.data()["32"]),
                    FlSpot(330, test.data()["33"]),
                    FlSpot(340, test.data()["34"]),
                    FlSpot(350, test.data()["35"]),
                    FlSpot(360, test.data()["36"]),
                    FlSpot(370, test.data()["37"]),
                    FlSpot(380, test.data()["38"]),
                    FlSpot(390, test.data()["39"]),
                    FlSpot(1440, test.data()["143"])
                  ],
                  isCurved: true,
                  colors: gradientColors,
                  barWidth: 5,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
