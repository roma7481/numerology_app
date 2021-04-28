import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

class ExpandableTile extends StatefulWidget {
  final String header;
  final String content;
  final String iconPath;

  ExpandableTile(this.header, this.content, {this.iconPath});

  @override
  _ExpandableTileState createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ExpansionTile(
        tilePadding: EdgeInsets.only(left: 0.0, right: 8.0),
        title:
            _collapsedContent(widget.header, widget.content, widget.iconPath),
        children:
            _expandedContent(widget.header, widget.content, widget.iconPath),
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpand = isExpanded;
          });
        },
      ),
    );
  }

  List<Widget> _expandedContent(
      String header, String content, String iconPath) {
    return [_buildCardContent(content)];

    /// nothing here, header is already colapsable expandable
  }

  Widget _collapsedContent(String header, String content, String iconPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(header, iconPath),
        _isExpand ? Container() : _buildCardContent(content),
        _buildReadMore(),
      ],
    );
  }

  Widget _buildHeader(String header, String iconPath) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 24.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconPath != null
                ? SvgPicture.asset(iconPath, height: 20.0)
                : Container(),
            Flexible(
              child: Text(
                header,
                style: descriptionHeaderStyle,
              ),
            ),
            Opacity(
                opacity: 0.0,
                child: iconPath != null
                    ? SvgPicture.asset(iconPath, height: 20.0)
                    : Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent(String content) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 16.0, left: 16.0, right: 8.0, bottom: 8.0),
      child: Text(content,
          maxLines: !_isExpand ? 4 : 2000,
          style: descriptionContentStyle(),
          overflow: !_isExpand ? TextOverflow.ellipsis : TextOverflow.visible),
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
