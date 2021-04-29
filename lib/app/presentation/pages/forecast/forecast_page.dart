import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast_cubit.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast_index_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/ads/native_admob_controller.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';
import 'package:numerology/app/presentation/pages/home/day_category.dart';

import 'forecast_button.dart';

class ForecastPage extends StatefulWidget {
  final NativeAdmobController adController = NativeAdmobController();

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
  void initState() {
    super.initState();
    context.read<ForecastIndexCubit>().emitDayClicked(0);
    context.read<ForecastIndexCubit>().emitLuckyClicked(0);
    context.read<ForecastIndexCubit>().emitMonthClicked(0);
    context.read<ForecastIndexCubit>().emitYearClicked(0);
  }

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

  Widget _buildContent() {
    return FutureBuilder<bool>(
        future: PremiumController.instance.isPremium(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return progressBar();
            default:
              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: errorDialog(),
                );
              } else {
                var isPremium = snapshot.data;
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    brightness: Brightness.dark,
                    title: Text(Globals.instance.language.forecast),
                  ),
                  body: _buildPageBody(isPremium),
                );
              }
          }
        });
  }

  Widget _buildPageBody(bool isPremium) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _categoryDayBuilder(_daily, _onDailyPressed, isPremium),
          _buildLine(),
          _categoryLuckyBuilder(_lucky, _onLuckyPressed, isPremium),
          _buildLine(),
          _showAd(isPremium),
          _categoryMonthBuilder(_monthly, _onMonthlyPressed, isPremium),
          _buildLine(),
          _categoryYearBuilder(_annual, _onYearPressed, isPremium),
        ],
      ),
    );
  }

  Widget _showAd(bool isPremium) {
    return SliverToBoxAdapter(
      child: showNativeAd(widget.adController, isPremium: isPremium),
    );
  }

  Widget _categoryLuckyBuilder(
      Forecast forecast, Function onPressed, bool isPremium) {
    return BlocBuilder<ForecastIndexCubit, ForecastIndexState>(
        builder: (context, state) {
      if (state is ForecastLuckyClicked) {
        _luckyBtnIndex = state.index;
        return _buildCategory(forecast, onPressed, state.index, isPremium);
      } else if (state is ForecastLoading) {
        return SliverToBoxAdapter(child: progressBar());
      }
      return _buildCategory(forecast, onPressed, _luckyBtnIndex, isPremium);
    });
  }

  Widget _categoryMonthBuilder(
      Forecast forecast, Function onPressed, bool isPremium) {
    return BlocBuilder<ForecastIndexCubit, ForecastIndexState>(
        builder: (context, state) {
      if (state is ForecastMonthClicked) {
        _monthlyBtnIndex = state.index;
        return _buildCategory(forecast, onPressed, state.index, isPremium);
      } else if (state is ForecastLoading) {
        return SliverToBoxAdapter(child: progressBar());
      }
      return _buildCategory(forecast, onPressed, _monthlyBtnIndex, isPremium);
    });
  }

  Widget _categoryYearBuilder(
      Forecast forecast, Function onPressed, bool isPremium) {
    return BlocBuilder<ForecastIndexCubit, ForecastIndexState>(
        builder: (context, state) {
      if (state is ForecastYearClicked) {
        _yearBtnIndex = state.index;
        return _buildCategory(forecast, onPressed, state.index, isPremium);
      } else if (state is ForecastLoading) {
        return SliverToBoxAdapter(child: progressBar());
      }
      return _buildCategory(forecast, onPressed, _yearBtnIndex, isPremium);
    });
  }

  Widget _categoryDayBuilder(
      Forecast forecast, Function onPressed, bool isPremium) {
    return BlocBuilder<ForecastIndexCubit, ForecastIndexState>(
        builder: (context, state) {
      if (state is ForecastDayClicked) {
        _dailyBtnIndex = state.index;
        return _buildCategory(forecast, onPressed, state.index, isPremium);
      } else if (state is ForecastLoading) {
        return SliverToBoxAdapter(child: progressBar());
      }
      return _buildCategory(forecast, onPressed, _dailyBtnIndex, isPremium);
    });
  }

  Widget _buildCategory(Forecast forecast, Function onPressed,
      int selectedButton, bool isPremium) {
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
                    onPressed: () => onPressed(0,isPremium)),
                ForecastButton(
                    isSelected: selectedButton == 1,
                    child: Text(
                      forecast.btnTitles[1],
                      style: buttonTextStyle,
                    ),
                    onPressed: () => onPressed(1,isPremium)),
                ForecastButton(
                    isSelected: selectedButton == 2,
                    child: Text(
                      forecast.btnTitles[2],
                      style: buttonTextStyle,
                    ),
                    onPressed: () => onPressed(2,isPremium)),
              ],
            ),
          ),
          _buildCategoryCard(forecast, selectedButton),
        ],
      ),
    );
  }

  Future<void> _onDailyPressed(int index, bool isPremium) async {
    if(isPremium){
      await context.read<ForecastIndexCubit>().emitDayClicked(index);
    } else{
      navigateToPremium(context);
    }
  }

  Future<void> _onLuckyPressed(int index, bool isPremium) async {
    if(isPremium){
      await context.read<ForecastIndexCubit>().emitLuckyClicked(index);
    } else{
      navigateToPremium(context);
    }
  }

  Future<void> _onMonthlyPressed(int index, bool isPremium) async {
    if(isPremium){
      await context.read<ForecastIndexCubit>().emitMonthClicked(index);
    } else{
      navigateToPremium(context);
    }
  }

  Future<void> _onYearPressed(int index, bool isPremium) async {
    if(isPremium){
      await context.read<ForecastIndexCubit>().emitYearClicked(index);
    } else{
      navigateToPremium(context);
    }
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
