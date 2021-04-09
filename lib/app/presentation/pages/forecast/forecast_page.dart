import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/pages/home/day_category.dart';

import 'forecast_button.dart';

class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return _buildContent();
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
        slivers: [_buildCategory()],
      ),
    );
  }

  Widget _buildCategory() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              'cat header',
              style: forecastCardHeader,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ForecastButton(
                    child: Text(
                      'waebtn1',
                      style: buttonTextStyle,
                    ),
                    onPressed: () {}),
                ForecastButton(
                    child: Text(
                      'qwebtn2',
                      style: buttonTextStyle,
                    ),
                    onPressed: () {}),
                ForecastButton(
                    child: Text(
                      'qwebtn3',
                      style: buttonTextStyle,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
          _buildCategoryCard(),
          _buildLine(),
        ],
      ),
    );
  }

  Widget _buildLine() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.90,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCategoryCard() {
    return buildDayCategory(
      text: 'category.text',
      content: 'category.content',
      onPressed: () async {
      },
      imagePath: day,
    );
  }
}
