import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business_logic/globals/globals.dart';
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

  Widget _buildCardContent() {
    final isContentEmpty = widget.content == null || widget.content!.isEmpty;

    if (isContentEmpty) return SizedBox();

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
          if (_isExpand) _buildHealingSoundsPromotion(),
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
    if (widget.promotionLink.isEmpty) return SizedBox();

    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(widget.promotionLink), mode: LaunchMode.externalApplication);
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
                  text: Globals.instance.getLanguage().healingSoundsPromotion1,
                  style: descriptionContentStyle()),
              TextSpan(
                  text: Globals.instance.getLanguage().healingSoundsPromotion2,
                  style: urlLinkStyle),
              TextSpan(
                  text: Globals.instance.getLanguage().healingSoundsPromotion3,
                  style: descriptionContentStyle()),
              TextSpan(text: '\n'),
            ],
          ),
        ),
      ),
    );
  }
}

