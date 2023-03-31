import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/card_header.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ad_widget_tag.dart';

class ExpandableTile extends StatefulWidget {
  final String header;
  final String content;
  final String iconPath;
  final String promotionLink;

  ExpandableTile(this.header, this.content, {this.iconPath, this.promotionLink = ''});

  @override
  _ExpandableTileState createState() => _ExpandableTileState(header,content,iconPath,promotionLink);
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool _isExpand = false;
  final String _header;
  final String _content;
  final String _iconPath;
  final String _promotionLink;

  _ExpandableTileState(this._header, this._content, this._iconPath, this._promotionLink);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ExpansionTile(
        tilePadding: EdgeInsets.only(left: 0.0, right: 8.0),
        title:
            _collapsedContent(),
        children:
            _expandedContent(),
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpand = isExpanded;
          });
        },
      ),
    );
  }

  List<Widget> _expandedContent() {
    return [_buildCardContent()];

    /// nothing here, header is already colapsable expandable
  }

  Widget _collapsedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(_header, _iconPath),
        _isExpand ? Container() : _buildCardContent(),
        _buildReadMore(),
      ],
    );
  }

  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, left: 16.0, right: 8.0, bottom: 16.0),
      child: Column(
        children: [
          Text(_content,
              maxLines: !_isExpand ? 4 : 2000,
              style: descriptionContentStyle(),
              overflow: !_isExpand ? TextOverflow.ellipsis : TextOverflow.visible),
          _buildHealingSoundsPromotion()
        ],
      ),
    );
  }

  Widget _buildHealingSoundsPromotion() {
    if(!_isExpand || _promotionLink.isEmpty){
      return Container();
    }

    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(_promotionLink),mode: LaunchMode.externalApplication);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new RichText(
          text: new TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            children: [
              WidgetSpan(child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: adWidgetTag(),
              )),
              new TextSpan(text: Globals.instance.getLanguage().healingSoundsPromotion1, style: descriptionContentStyle()),
              new TextSpan(text: Globals.instance.getLanguage().healingSoundsPromotion2, style: urlLinkStyle),
              new TextSpan(text: Globals.instance.getLanguage().healingSoundsPromotion3, style: descriptionContentStyle()),
              new TextSpan(text: '\n'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadMore() {
    if (_isExpand) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
      child: Text(Globals.instance.language.readMore,
          textAlign: TextAlign.start, style: readMoreStyle),
    );
  }
}
