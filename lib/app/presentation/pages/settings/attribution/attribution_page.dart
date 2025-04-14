import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:url_launcher/url_launcher.dart';

class AttributionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildAppBarContent(), systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildAppBarContent() {
    return Text(
      Globals.instance.getLanguage().info,
      style: headerTextStyle,
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Align(
            //To make container wrap parent you can wrap it in align
            alignment: Alignment.topCenter,
            child: CustomCard(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 16.0, bottom: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildContentRow('https://www.flaticon.com'),
                    _buildContentRow('https://mechtayte.ru/'),
                    _buildContentRow('http://www.cluber.com.ua/'),
                    _buildContentRow('magya-online.ru/'),
                    _buildContentRow('http://geocult.ru/'),
                    _buildContentRow('https://inpot.ru/'),
                    _buildContentRow('https://www.sonnik-online.net/'),
                    _buildContentRow('https://www.tsemrinpoche.com/'),
                    _buildContentRow('https://www.freepik.com'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentRow(String url) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () async {
          try {
            if (await canLaunch(url)) {
              await launch(url);
            }
          } catch (e) {
            Fluttertoast.showToast(
              msg: Globals.instance.language.errorTryLater,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Text(
            url,
            style: urlLinkStyle,
          ),
        ),
      ),
    );
  }
}
