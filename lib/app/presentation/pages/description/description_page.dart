import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/app/business_logic/services/ads/show_banner.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/common_widgets/list_space_tile.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';

import 'circle_widget.dart';
import 'matrix_line_data.dart';

class DescriptionPage extends StatelessWidget {
  final String header;
  final String calculation;
  final List<CardData> data;

  DescriptionPage({
    this.calculation = '',
    this.header = '',
    this.data = const [],
  });

  @override
  Widget build(BuildContext context) {
    var banner = getBanner();
    var adWidget = banner == null ? null : AdWidget(ad: banner);

    return FutureBuilder<bool>(
        future: PremiumController.instance.isAdsFree(),
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
                return _buildPageContent(
                  context,
                  banner,
                  adWidget,
                  isPremium,
                );
              }
          }
        });
  }

  Widget _buildPageContent(
    BuildContext context,
    BannerAd banner,
    AdWidget adWidget,
    bool isPremium,
  ) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text(header), brightness: Brightness.dark),
      body: _buildContext(
        context,
        banner,
        adWidget,
        isPremium,
      ),
      bottomNavigationBar: showBanner(adWidget, banner, isPremium),
    );
  }

  Widget _buildContext(
    BuildContext context,
    BannerAd banner,
    AdWidget adWidget,
    bool isPremium,
  ) {
    var listHeight = calcListHeight(context, banner, isPremium);

    return Container(
        color: backgroundColor,
        child: Wrap(
          children: [
            Column(
              children: [
                SizedBox(
                  height: listHeight,
                  child: CustomScrollView(
                    slivers: [
                      _buildNumberIcon(context, calculation),
                      _buildList(data, isPremium),
                      buildSpaceBox(context),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildNumberIcon(BuildContext context, String calculation) {
    if (calculation.isEmpty) {
      return SliverToBoxAdapter(child: Container());
    }
    return SliverToBoxAdapter(
      child: Container(
        width: 400,
        height: 200,
        child: CustomPaint(
          painter: OpenPainter(context, calculation),
        ),
      ),
    );
  }

  Widget _buildList(List<CardData> data, bool isPremium) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var item = data[index];
        return Column(children: [
          showAdInList(data, index, isPremium),
          ExpandableTile(item.header, item.description,
              iconPath: item.iconPath, promotionLink: item.promotionAppLink,),
        ]);
      },
      childCount: data.length,
    ));
  }
}
