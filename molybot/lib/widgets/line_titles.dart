import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 10,
          interval: 360,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '00.00';
              case 180:
                return '03.00';
              case 360:
                return '06.00';
              case 540:
                return '09.00';
              case 720:
                return '12.00';
              case 900:
                return '15.00';
              case 1080:
                return '18.00';
              case 1260:
                return '21.00';
              case 1440:
                return '24.00';
            }
            return '';
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 100,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 5,
          ),
          getTitles: (value) {
            // switch (value.toInt()) {
            //   case 2500:
            //     return '25k';
            //   case 3000:
            //     return '3k';
            //   case 3500:
            //     return '3.5k';
            // }
            return value.toString();
          },
          reservedSize: 10,
          margin: 12,
        ),
      );
}
