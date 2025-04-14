import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:provider/provider.dart';

class GraphWidget extends StatefulWidget {
  final Profile? profile;
  final bool isPrimaryBioGraph;

  const GraphWidget({Key? key, this.profile, this.isPrimaryBioGraph = true})
      : super(key: key);

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  late double minX;
  late double maxX;
  final _scrollDelta = 0.4;
  bool _isTapEnabled = true;
  LineTouchResponse? _touchResponse;

  @override
  void initState() {
    super.initState();
    minX = -4;
    maxX = 4;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 36),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: tileColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 4.0, left: 4.0, top: 24, bottom: 8),
                child: Listener(
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dragUpdDet) {
                      setState(() {
                        _isTapEnabled = false;
                        _touchResponse = null;
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
        CategoryCalc.instance.calcDaysAfterBorn(widget.profile!.dob!);

    return List.generate(365 * 11, (i) => (i - 365 * 2) / 5)
        .where((element) => element >= minX && element <= maxX)
        .map((x) => FlSpot(x, _calcY(numDaysSinceBorn, x, daysInterval)))
        .toList();
  }

  double _calcY(int numDaysSinceBorn, double x, double daysInterval) {
    return double.parse(
        (sin(2.0 * pi * (numDaysSinceBorn + x) / daysInterval) * 100.0)
            .toStringAsFixed(1));
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
          enabled: _isTapEnabled,
          touchCallback: (event, touchResponse) {
            setState(() {
              _touchResponse = touchResponse;
              updatePiCharts();
            });
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white,
          ),
      ),
      gridData: FlGridData(
        show: true,
        verticalInterval: 1.0,
        horizontalInterval: 40.0,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            reservedSize: 44,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12), // move text downward
                    child: Transform.rotate(
                      angle: -45 * pi / 180, // rotate 45 degrees
                      child: Text(
                        _getDateRange(value),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
        leftTitles: _buildSideTiles(),
        rightTitles: _buildSideTiles(),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: minX,
      maxX: maxX,
      minY: -120,
      maxY: 120,
      lineBarsData: _getBarsData(),
    );
  }

  List<LineChartBarData> _getBarsData() {
    if (widget.isPrimaryBioGraph) {
      return [
        _buildCurve(_generateSpots(23.0), physicalColors),
        _buildCurve(_generateSpots(28.0), emotionColors),
        _buildCurve(_generateSpots(33.0), intelColors),
      ];
    }
    return [
      _buildCurve(_generateSpots(53.0), spiritColors), //spirit
      _buildCurve(_generateSpots(38.0), intuitColors), //intuition
      _buildCurve(_generateSpots(48.0), awareColors), //awareness
      _buildCurve(_generateSpots(43.0), aestheticColors), //aesthetic
    ];
  }

  AxisTitles _buildSideTiles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 30, // <-- Show every 30%
        reservedSize: 44,
        getTitlesWidget: (value, meta) {
          final int rounded = value.round();

          if (rounded % 30 != 0 || rounded.abs() > 90) {
            return const SizedBox.shrink();
          }

          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 8,
            child: Text(
              "$rounded%",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: graphDates,
              ),
            ),
          );

        },
      ),
    );
  }

  void updatePiCharts() {
    widget.isPrimaryBioGraph ? _updateForPrim() : _updateForSecond();
  }

  void _updateForPrim() {
    if (_touchResponse != null) {
      if (_touchResponse!.lineBarSpots != null &&
          _touchResponse!.lineBarSpots!.isNotEmpty) {
        context.read<BioCubit>().emitBioUpdate(
          [
            _touchResponse!.lineBarSpots![0].y,
            _touchResponse!.lineBarSpots![1].y,
            _touchResponse!.lineBarSpots![2].y,
          ],
          date: _getSelectedDate(_touchResponse!.lineBarSpots![0].x),
        );
      }
    }
  }

  void _updateForSecond() {
    if (_touchResponse != null) {
      if (_touchResponse!.lineBarSpots != null &&
          _touchResponse!.lineBarSpots!.isNotEmpty) {
        context.read<BioSecondCubit>().emitBioUpdate(
          [
            _touchResponse!.lineBarSpots![0].y,
            _touchResponse!.lineBarSpots![1].y,
            _touchResponse!.lineBarSpots![2].y,
            _touchResponse!.lineBarSpots![3].y,
          ],
          date: _getSelectedDate(_touchResponse!.lineBarSpots![0].x),
        );
      }
    }
  }

  String _getDateRange(double value) {
    var numDays = value.round();
    if (numDays.isOdd) {
      var currentDay = DateTime.now();
      var newDate = new DateTime(
          currentDay.year, currentDay.month, currentDay.day + numDays);

      return DateService.getShortFormattedDate(newDate);
    }
    return '';
  }

  int _getSelectedDate(double value) {
    var numDays = value.round();
    var currentDay = DateTime.now();
    var newDate = new DateTime(
        currentDay.year, currentDay.month, currentDay.day + numDays);
    return DateService.toTimestamp(newDate);
  }

  LineChartBarData _buildCurve(List<FlSpot> spots, List<Color> gradient) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      gradient: LinearGradient(colors: gradient),
      barWidth: 12,
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
