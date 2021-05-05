import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'line_titles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  double counter = 0;
  String stval = "";
  List list;

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
              minY: 3200,
              //minY: test.data()["min"] - 100,
              maxY: test.data()["max"] + 100,
              //maxY: 3300,
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
                    //FlSpot(10, test.data()["1"]),
                    FlSpot(20, test.data()["2"]),
                    //FlSpot(30, test.data()["3"]),
                    FlSpot(40, test.data()["4"]),
                    //FlSpot(50, test.data()["5"]),
                    FlSpot(60, test.data()["6"]),
                    //FlSpot(70, test.data()["7"]),
                    FlSpot(80, test.data()["8"]),
                    //FlSpot(90, test.data()["9"]),
                    FlSpot(100, test.data()["10"]),
                    //FlSpot(110, test.data()["11"]),
                    FlSpot(120, test.data()["12"]),
                    //FlSpot(130, test.data()["13"]),
                    FlSpot(140, test.data()["14"]),
                    //FlSpot(150, test.data()["15"]),
                    FlSpot(160, test.data()["16"]),
                    //FlSpot(170, test.data()["17"]),
                    FlSpot(180, test.data()["18"]),
                    //FlSpot(190, test.data()["19"]),
                    FlSpot(200, test.data()["20"]),
                    //FlSpot(210, test.data()["21"]),
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
                    FlSpot(400, test.data()["40"]),
                    FlSpot(410, test.data()["41"]),
                    FlSpot(420, test.data()["42"]),
                    FlSpot(430, test.data()["43"]),
                    FlSpot(440, test.data()["44"]),
                    FlSpot(450, test.data()["45"]),
                    FlSpot(460, test.data()["46"]),
                    FlSpot(470, test.data()["47"]),
                    FlSpot(480, test.data()["48"]),
                    FlSpot(490, test.data()["49"]),
                    FlSpot(500, test.data()["50"]),
                    FlSpot(510, test.data()["51"]),
                    FlSpot(520, test.data()["52"]),
                    FlSpot(530, test.data()["53"]),
                    FlSpot(540, test.data()["54"]),
                    FlSpot(550, test.data()["55"]),
                    FlSpot(560, test.data()["56"]),
                    FlSpot(570, test.data()["57"]),
                    FlSpot(580, test.data()["58"]),
                    FlSpot(590, test.data()["59"]),
                    FlSpot(600, test.data()["60"]),
                    FlSpot(610, test.data()["61"]),
                    FlSpot(620, test.data()["62"]),
                    FlSpot(630, test.data()["63"]),
                    FlSpot(640, test.data()["64"]),
                    FlSpot(650, test.data()["65"]),
                    FlSpot(660, test.data()["66"]),
                    FlSpot(670, test.data()["67"]),
                    FlSpot(680, test.data()["68"]),
                    FlSpot(690, test.data()["69"]),
                    FlSpot(700, test.data()["70"]),
                    FlSpot(710, test.data()["71"]),
                    FlSpot(720, test.data()["72"]),
                    FlSpot(730, test.data()["73"]),
                    FlSpot(740, test.data()["74"]),
                    FlSpot(750, test.data()["75"]),
                    FlSpot(760, test.data()["76"]),
                    FlSpot(770, test.data()["77"]),
                    FlSpot(780, test.data()["78"]),
                    FlSpot(790, test.data()["79"]),
                    FlSpot(800, test.data()["80"]),
                    FlSpot(810, test.data()["81"]),
                    FlSpot(820, test.data()["82"]),
                    FlSpot(830, test.data()["83"]),
                    FlSpot(840, test.data()["84"]),
                    FlSpot(850, test.data()["85"]),
                    FlSpot(860, test.data()["86"]),
                    FlSpot(870, test.data()["87"]),
                    FlSpot(880, test.data()["88"]),
                    FlSpot(890, test.data()["89"]),
                    FlSpot(900, test.data()["90"]),
                    FlSpot(910, test.data()["91"]),
                    FlSpot(920, test.data()["92"]),
                    FlSpot(930, test.data()["93"]),
                    FlSpot(940, test.data()["94"]),
                    FlSpot(950, test.data()["95"]),
                    FlSpot(960, test.data()["96"]),
                    FlSpot(970, test.data()["97"]),
                    FlSpot(980, test.data()["98"]),
                    FlSpot(990, test.data()["99"]),
                    FlSpot(1000, test.data()["100"]),
                    FlSpot(1010, test.data()["101"]),
                    FlSpot(1020, test.data()["102"]),
                    FlSpot(1030, test.data()["103"]),
                    FlSpot(1040, test.data()["104"]),
                    FlSpot(1050, test.data()["105"]),
                    FlSpot(1060, test.data()["106"]),
                    FlSpot(1070, test.data()["107"]),
                    FlSpot(1080, test.data()["108"]),
                    FlSpot(1090, test.data()["109"]),
                    FlSpot(1100, test.data()["110"]),
                    FlSpot(1110, test.data()["111"]),
                    FlSpot(1120, test.data()["112"]),
                    FlSpot(1130, test.data()["113"]),
                    FlSpot(1140, test.data()["114"]),
                    FlSpot(1150, test.data()["115"]),
                    FlSpot(1160, test.data()["116"]),
                    FlSpot(1170, test.data()["117"]),
                    FlSpot(1180, test.data()["118"]),
                    FlSpot(1190, test.data()["119"]),
                    FlSpot(1200, test.data()["120"]),
                    FlSpot(1210, test.data()["121"]),
                    FlSpot(1220, test.data()["122"]),
                    FlSpot(1230, test.data()["123"]),
                    FlSpot(1240, test.data()["124"]),
                    FlSpot(1250, test.data()["125"]),
                    FlSpot(1260, test.data()["126"]),
                    FlSpot(1270, test.data()["127"]),
                    FlSpot(1280, test.data()["128"]),
                    FlSpot(1290, test.data()["129"]),
                    FlSpot(1300, test.data()["130"]),
                    FlSpot(1310, test.data()["131"]),
                    FlSpot(1320, test.data()["132"]),
                    FlSpot(1330, test.data()["133"]),
                    FlSpot(1340, test.data()["134"]),
                    FlSpot(1350, test.data()["135"]),
                    FlSpot(1360, test.data()["136"]),
                    FlSpot(1370, test.data()["137"]),
                    FlSpot(1380, test.data()["138"]),
                    FlSpot(1390, test.data()["139"]),
                    FlSpot(1400, test.data()["140"]),
                    FlSpot(1410, test.data()["141"]),
                    // FlSpot(1420, test.data()["142"]),
                    FlSpot(1430, test.data()["143"]),
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
