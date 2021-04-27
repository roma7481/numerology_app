import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/app/business_logic/services/ads/native_admob_controller.dart';
import 'package:numerology/app/business_logic/services/ads/show_banner.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';

import 'matrix_line_data.dart';
import 'matrix_utils.dart';

class MatrixLinesPage extends StatelessWidget {
  final String header;
  final String calculation;
  final List<CardData> data;
  final List<int> matrix;
  final Map<String, String> info;
  final NativeAdmobController adController;

  BannerAd _banner;
  AdWidget _adWidget;

  MatrixLinesPage(
    this.adController, {
    Key key,
    this.header = '',
    this.calculation = '',
    this.data = const [],
    this.matrix = const [],
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                _loadBanner(isPremium);
                return _buildPageContent(context, isPremium);
              }
          }
        });
  }

  void _loadBanner(bool isPremium) {
    if (isPremium) {
      return;
    }
    _banner = getBanner();
    _banner.load();
    _adWidget = AdWidget(ad: _banner);
  }

  Widget _buildPageContent(BuildContext context, bool isPremium) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text(header), brightness: Brightness.dark),
      body: _buildContext(context, isPremium),
    );
  }

  Widget _buildContext(BuildContext context, bool isPremium) {
    var listHeight = calcListHeight(context, _banner, isPremium);

    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: listHeight,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: buildMatrix(context, matrix)),
                _buildList(isPremium),
                _buildInfo(),
              ],
            ),
          ),
          showBanner(_adWidget, _banner, isPremium),
        ],
      ),
    );
  }

  Widget _buildList(bool isPremium) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var item = data[index];
        return Column(
          children: [
            showAdInList(adController, data, index, isPremium),
            buildExpandCard(item.header, item.description, item.iconPath),
          ],
        );
      },
      childCount: data.length,
    ));
  }

  Widget _buildInfo() {
    return SliverToBoxAdapter(
      child: CustomCard(
        child: CustomCategoryCard(
          header: info.keys.first,
          content: info.values.first,
        ),
      ),
    );
  }
}
