import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast_cubit.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/pages/home/day_category.dart';

import 'forecast_button.dart';

class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  var _daily;
  var _dailyBtnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastCubit, ForecastState>(builder: (context, state) {
      if (state is ForecastReady) {
        _daily = state.daily;
        return _buildContent();
      } else if (state is ForecastError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Scaffold _buildContent() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text('header'),
      ),
      body: _buildPageBody(),
    );
  }

  Widget _buildPageBody() {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildCategory(_daily, _onDailyPressed, _dailyBtnIndex),
          _buildLine(),
        ],
      ),
    );
  }

  Widget _buildCategory(
      Forecast forecast, Function onPressed, int selectedButton) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              forecast.title,
              style: forecastCardHeader,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ForecastButton(
                    isSelected: selectedButton == 0,
                    child: Text(
                      forecast.btnTitles[0],
                      style: buttonTextStyle,
                    ),
                    onPressed: () => _onDailyPressed(0)),
                ForecastButton(
                    isSelected: selectedButton == 1,
                    child: Text(
                      forecast.btnTitles[1],
                      style: buttonTextStyle,
                    ),
                    onPressed: () => _onDailyPressed(1)),
                ForecastButton(
                    isSelected: selectedButton == 2,
                    child: Text(
                      forecast.btnTitles[2],
                      style: buttonTextStyle,
                    ),
                    onPressed: () => _onDailyPressed(2)),
              ],
            ),
          ),
          _buildCategoryCard(forecast, _dailyBtnIndex),
        ],
      ),
    );
  }

  void _onDailyPressed(int index) {
    setState(() {
      _dailyBtnIndex = index;
    });
  }

  Widget _buildLine() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 1.0,
          width: MediaQuery.of(context).size.width * 0.90,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Forecast forecast, int selectedBtn) {
    return buildDayCategory(
      text: forecast.cardTitle,
      content: forecast.contents[selectedBtn],
      onPressed: () {},
      imagePath: forecast.iconPath,
    );
  }
}
