import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business_logic/globals/globals.dart';
import '../../business_logic/services/app_links_service.dart';
import '../../constants/text_styles.dart';
import 'ad_widget_tag.dart';
import 'card_header.dart';
import 'custom_card.dart';

class ExpandableTile extends StatefulWidget {
  final String? header;
  final String? content;
  final String? iconPath;
  final String promotionLink;

  ExpandableTile(this.header, this.content, {this.iconPath, this.promotionLink = ''});

  @override
  _ExpandableTileState createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _isExpand = !_isExpand;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderWithToggle(), // includes the header + top-right icon
            _buildCardContent(),      // includes preview or full content
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderWithToggle() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: buildHeader(widget.header, widget.iconPath)),
        ],
      ),
    );
  }

  int? _promoIndex;


  late final List<Widget Function()> _promoBuilders; // declare only

  @override
  void initState() {
    super.initState();
    _promoBuilders = [
      _buildHealingSoundsPromotion,
      _buildHTarotCardOfDayPromotion,
      _buildRunePromotion,
    ];
  }

  Widget _buildCardContent() {
    final isContentEmpty = widget.content == null || widget.content!.isEmpty;
    if (isContentEmpty) return const SizedBox();

    if (_isExpand && _promoIndex == null) {
      _promoIndex = Random().nextInt(_promoBuilders.length);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 8.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.content!,
            maxLines: _isExpand ? 2000 : 6,
            overflow: _isExpand ? TextOverflow.visible : TextOverflow.ellipsis,
            style: descriptionContentStyle(),
          ),
          if (!_isExpand) _buildReadMore(),
          if (_isExpand && _promoIndex != null)
            _promoBuilders[_promoIndex!](),
        ],
      ),
    );
  }

  Widget _buildReadMore() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        Globals.instance.language.readMore,
        style: readMoreStyle,
        textAlign: TextAlign.start,
      ),
    );
  }

    Widget _buildHealingSoundsPromotion() {
    return _buildPromotion(AppLinksService.instance.healingSoundsUrl,
        Globals.instance.getLanguage().healingSoundsPromotion1,
        Globals.instance.getLanguage().healingSoundsPromotion2,
        Globals.instance.getLanguage().healingSoundsPromotion3);
  }

  Widget _buildHTarotCardOfDayPromotion() {
    return _buildPromotion(AppLinksService.instance.tarotUrl,
        Globals.instance.getLanguage().tarotPromotion1,
        Globals.instance.getLanguage().tarotPromotion2,
        Globals.instance.getLanguage().tarotPromotion3);
  }

  Widget _buildRunePromotion() {
    return _buildPromotion(AppLinksService.instance.runesUrl,
        Globals.instance.getLanguage().runePromotion1,
        Globals.instance.getLanguage().runePromotion2,
        Globals.instance.getLanguage().runePromotion3);
  }

  Widget _buildPromotion(url,text1,text2,text3) {
    if (url == null || url.isEmpty) return SizedBox();

    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: adWidgetTag(),
                ),
              ),
              TextSpan(
                  text: text1,
                  style: descriptionContentStyle()),
              TextSpan(
                  text: text2,
                  style: urlLinkStyle),
              TextSpan(
                  text: text3,
                  style: descriptionContentStyle()),
              TextSpan(text: '\n'),
            ],
          ),
        ),
      ),
    );
  }
}

