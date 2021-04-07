import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';

class LineChartSample extends StatefulWidget {
  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  double minX;
  double maxX;
  final scrollDelta = 0.01;

  @override
  void initState() {
    super.initState();
    minX = 0;
    maxX = 8;
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
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dragUpdDet) {
                      setState(() {
                        print(dragUpdDet.primaryDelta);
                        double primDelta = dragUpdDet.primaryDelta ?? 0.0;
                        if (primDelta != 0) {
                          if (primDelta.isNegative) {
                            minX += maxX * scrollDelta;
                            maxX += maxX * scrollDelta;
                          } else {
                            minX -= maxX * scrollDelta;
                            maxX -= maxX * scrollDelta;
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

  List<FlSpot> _generateSpots(double daysInterval){
    return List.generate(365 * 11, (i) => (i) / 10)
        .where((element) => element > minX && element < maxX)
        .map((x) => FlSpot(x, sin(2.0 * pi * x / daysInterval) * 100.0))
        .toList();
  }

  LineChartData mainData() {
    final spotsPhys = _generateSpots(23.0);
    final spotsEmotion = _generateSpots(28.0);
    final spotsIntel = _generateSpots(33.0);

    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        verticalInterval: 1.0,
        horizontalInterval: 40.0,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          rotateAngle: -45.0,
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: graphDates, fontWeight: FontWeight.bold, fontSize: 12),
          getTitles: (value) {
            return _getDateRange(value);
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: graphDates,
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
        _buildCurve(spotsPhys, physicalColors),
        _buildCurve(spotsEmotion, emotionColors),
        _buildCurve(spotsIntel, intelColors),
      ],
    );
  }

  String _getDateRange(double value) {
    var numDays = value.toInt() - 1;
    if (numDays.isOdd && value > 0) {
      var currentDay = DateTime.now();
      var newDate = new DateTime(
          currentDay.year, currentDay.month, currentDay.day + numDays);

      return DateService.getShortFormattedDate(newDate);
    }
    return '';
  }

  LineChartBarData _buildCurve(List<FlSpot> spots, List<Color> gradient) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: gradient,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }
}
