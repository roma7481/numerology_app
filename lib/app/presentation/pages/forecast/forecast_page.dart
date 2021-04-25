import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';
import 'package:numerology/app/presentation/pages/home/day_category.dart';

import 'forecast_button.dart';

class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  var _daily;
  var _profile;
  var _lucky;
  var _monthly;
  var _annual;
  var _dailyBtnIndex = 0;
  var _luckyBtnIndex = 0;
  var _monthlyBtnIndex = 0;
  var _yearBtnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        if (state.profile != _profile) {
          context.read<ForecastCubit>().updateForecast(state.profile);
        }
        _profile = state.profile;
        return BlocBuilder<ForecastCubit, ForecastState>(
            builder: (context, state) {
          if (state is ForecastReady) {
            _daily = state.daily;
            _lucky = state.lucky;
            _monthly = state.monthly;
            _annual = state.annual;
            return _buildContent();
          } else if (state is ForecastError) {
            return errorDialog();
          }
          return progressBar();
        });
      } else if (state is UserDataError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Scaffold _buildContent() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        title: Text(Globals.instance.language.forecast),
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
          _buildCategory(_lucky, _onLuckyPressed, _luckyBtnIndex),
          _buildLine(),
          _buildCategory(_monthly, _onMonthlyPressed, _monthlyBtnIndex),
          _buildLine(),
          _buildCategory(_annual, _onYearPressed, _yearBtnIndex),
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
                    onPressed: () => onPressed(0)),
                ForecastButton(
                    isSelected: selectedButton == 1,
                    child: Text(
                      forecast.btnTitles[1],
                      style: buttonTextStyle,
                    ),
                    onPressed: () => onPressed(1)),
                ForecastButton(
                    isSelected: selectedButton == 2,
                    child: Text(
                      forecast.btnTitles[2],
                      style: buttonTextStyle,
                    ),
                    onPressed: () => onPressed(2)),
              ],
            ),
          ),
          _buildCategoryCard(forecast, selectedButton),
        ],
      ),
    );
  }

  void _onDailyPressed(int index) {
    setState(() {
      _dailyBtnIndex = index;
    });
  }

  void _onLuckyPressed(int index) {
    setState(() {
      _luckyBtnIndex = index;
    });
  }

  void _onMonthlyPressed(int index) {
    setState(() {
      _monthlyBtnIndex = index;
    });
  }

  void _onYearPressed(int index) {
    setState(() {
      _yearBtnIndex = index;
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
    List<CardData> description = [];
    description.add(CardData(
        header: forecast.cardTitle,
        description: forecast.contents[selectedBtn]));
    description.add(CardData(
        header: Globals.instance.language.info, description: forecast.info));

    return buildDayCategory(
      header: forecast.cardTitle,
      content: forecast.contents[selectedBtn],
      onPressed: () => navigateToDescriptionPage(
        context,
        forecast.cardTitle,
        forecast.calc[selectedBtn].toString(),
        description,
      ),
      imagePath: forecast.iconPath,
    );
  }
}
