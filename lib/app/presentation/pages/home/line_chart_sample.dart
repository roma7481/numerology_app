import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';

class LineChartSample extends StatefulWidget {
  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  double minX;
  double maxX;

  @override
  void initState() {
    super.initState();
    minX = 0;
    maxX = 12;
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.20,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 32),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: tileColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: Listener(
                  // child: LineChart(
                  //   mainData(),
                  // ),
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dragUpdDet) {
                      setState(() {
                        print(dragUpdDet.primaryDelta);
                        double primDelta = dragUpdDet.primaryDelta ?? 0.0;
                        if (primDelta != 0) {
                          if (primDelta.isNegative) {
                            minX += maxX * 0.008;
                            maxX += maxX * 0.008;
                          } else {
                            minX -= maxX * 0.008;
                            maxX -= maxX * 0.008;
                          }
                        }
                      });
                    },
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    final spots = List.generate(365, (i) => (i) / 4)
        .map((x) => FlSpot(x, sin(2.0 * pi * x / 23.0) * 100.0))
        .toList();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        verticalInterval: 2.0,
        horizontalInterval: 40.0,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 90:
                return '90%';
              case 60:
                return '60%';
              case 30:
                return '30%';
              case 0:
                return '0%';
              case -90:
                return '-90%';
              case -60:
                return '-60%';
              case -30:
                return '-30%';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: minX,
      maxX: maxX,
      minY: -120,
      maxY: 120,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
