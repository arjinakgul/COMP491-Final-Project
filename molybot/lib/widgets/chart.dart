import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfSparkAreaChart(
              color: Colors.blue,
              trackball:
              SparkChartTrackball(borderWidth: 2, borderColor: Colors.black),
              data: <double>[
                -.5, 1,1,1, 5, 4,3,2,1
              ],
            )
    );
  }
}