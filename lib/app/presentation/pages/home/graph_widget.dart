import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:provider/provider.dart';

class GraphWidget extends StatefulWidget {
  final Profile profile;
  final Function onTap;

  const GraphWidget({Key key, this.profile, this.onTap}) : super(key: key);

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  double minX;
  double maxX;
  final _scrollDelta = 0.4;
  bool _isTapEnabled = true;

  @override
  void initState() {
    super.initState();
    minX = 0;
    maxX = 8;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.20,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: tileColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: Listener(
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dragUpdDet) {
                      setState(() {
                        _isTapEnabled = false;
                        print(dragUpdDet.primaryDelta);
                        double primDelta = dragUpdDet.primaryDelta ?? 0.0;
                        if (primDelta != 0) {
                          if (primDelta.isNegative) {
                            minX += _scrollDelta;
                            maxX += _scrollDelta;
                          } else {
                            minX -= _scrollDelta;
                            maxX -= _scrollDelta;
                          }
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        _isTapEnabled = true;
                      });
                    },
                    onTapDown: (TapDownDetails details) {
                      setState(() {
                        _isTapEnabled = true;
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

  List<FlSpot> _generateSpots(double daysInterval) {
    var numDaysSinceBorn =
        CategoryCalc.instance.calcDaysAfterBorn(widget.profile.dob);

    return List.generate(365 * 11, (i) => (i - 100) / 10)
        .where((element) => element > minX && element < maxX)
        .map((x) => FlSpot(x, _calcY(numDaysSinceBorn, x, daysInterval)))
        .toList();
  }

  double _calcY(int numDaysSinceBorn, double x, double daysInterval) {
    return double.parse(
        (sin(2.0 * pi * (numDaysSinceBorn + x) / daysInterval) * 100.0)
            .toStringAsFixed(1));
  }

  LineChartData mainData() {
    final spotsPhys = _generateSpots(23.0);
    final spotsEmotion = _generateSpots(28.0);
    final spotsIntel = _generateSpots(33.0);

    return LineChartData(
      lineTouchData: LineTouchData(
          enabled: _isTapEnabled,
          touchCallback: (LineTouchResponse touchResponse) {
            if (touchResponse.lineBarSpots != null &&
                touchResponse.lineBarSpots.isNotEmpty) {
              context.read<BioCubit>().emitBioUpdate(
                [
                  touchResponse.lineBarSpots[0].y,
                  touchResponse.lineBarSpots[1].y,
                  touchResponse.lineBarSpots[2].y,
                ],
              );
            }
          }),
      gridData: FlGridData(
        show: true,
        verticalInterval: 1.0,
        horizontalInterval: 40.0,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          rotateAngle: -55.0,
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
    var numDays = value.floor() - 1;
    if (numDays.isOdd) {
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
