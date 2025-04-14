import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/business_logic/cubit/purchases/purchases_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';

import 'info_button.dart';

class PayWall extends StatefulWidget {
  @override
  _PayWallState createState() => _PayWallState();
}

class _PayWallState extends State<PayWall> {
  void _onPurchaseError() {
    showToast(Globals.instance.getLanguage().purchaseError);
  }

  void _onSuccess() {
    showToast(Globals.instance.getLanguage().purchaseSuccess);
  }

  void _onCanceled() {
    showToast(Globals.instance.getLanguage().purchaseCanceled);
  }

  void _onRestored (){
    showToast(Globals.instance.getLanguage().purchaseRestored);
  }

  @override
  void initState() {
    super.initState();
    context.read<PurchasesCubit>().resetNumberPurchaseInitTries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchasesCubit, PurchasesState>(
        listener: (BuildContext context, state) {
          if (state is PurchasesCanceled) {
            _onCanceled();
          } else if(state is PurchasesSuccess){
            _onSuccess();
          }  else if(state is PurchasesRestored){
            _onRestored();
          } else if(state is PurchasesError){
            _onPurchaseError();
          } else if(state is PurchasesInitFailed){
            context.read<PurchasesCubit>().retryInitPurchase();
          }
        },
        builder: (context, state) {
          if (state is PurchasesInitFailed) {
            return errorDialog();
          } else if (state is PurchasesLoading) {
            return progressBar();
          }
          return _buildPageContent(context);
        });
  }

  Widget _buildPageContent(BuildContext context) {
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
      Globals.instance.getLanguage().premium,
      style: headerTextStyle,
    );
  }

  Widget _buildContent(BuildContext context) {
    var language = Globals.instance.getLanguage();
    var productDetails = context.read<PurchasesCubit>().productDetails;

    if (productDetails == null || productDetails.isEmpty) {
      return Center(child: Text("No products available"));
    }

    var premiumPrice =
        productDetails.where((element) => element.id == premiumKid).first.price;
    var compatPrice =
        productDetails.where((element) => element.id == compatKid).first.price;
    var profilePrice =
        productDetails.where((element) => element.id == profileKid).first.price;
    var adsFreePrice =
        productDetails.where((element) => element.id == adsKid).first.price;

    String discount = _calcDiscount(premiumPrice, adsFreePrice, profilePrice, compatPrice);

    return SafeArea(
      child: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Align(
            //To make container wrap parent you can wrap it in align
            alignment: Alignment.topCenter,
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(child: InfoButton()),
              _fullyPremium(context, language, premiumPrice, discount),
              _compatibility(context, language, compatPrice),
              _profiles(context, language, profilePrice),
              _adsFree(context, language, adsFreePrice)
            ]),
          ),
        ),
      ),
    );
  }

  String _calcDiscount(String premiumPrice, String adsFreePrice, String profilePrice, String compatPrice) {
    var res = (_priceFormat(premiumPrice) / (_priceFormat(adsFreePrice)
        + _priceFormat(profilePrice) + _priceFormat(compatPrice)));
    var discount = 100 - res * 100;
    return discount.toStringAsFixed(0);
  }

  double _priceFormat(String price){
   return  double.parse(price.substring(1, price.length-1));
  }

  Widget _fullyPremium(BuildContext context, Languages language, String price, String discount) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          CustomCard(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildContentHeaderRow(
                          context, language.goPremium, crown),
                      _buildContentRow(context, language.getCompatReport,
                          Icons.check_circle),
                      _buildContentRow(
                          context, language.openForecast, Icons.check_circle),
                      _buildContentRow(context, language.unlimitedProfiles,
                          Icons.check_circle),
                      _buildContentRow(
                          context, language.adsFree, Icons.check_circle),
                    ],
                  ),
                  _buildPriceColumn(
                      price, context, language, () => _onPremiumClick(context)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, right: 32.0),
            child: Align(
              alignment: Alignment.topRight,
              child: _buildDiscount(discount),
            ),
          ),
        ],
      ),
    );
  }

  Widget _adsFree(BuildContext context, Languages language, String price) {
    return SliverToBoxAdapter(
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContentHeaderRow(context, language.adsFree, ads),
                  _buildContentRow(
                      context, language.adsFree, Icons.check_circle),
                ],
              ),
              _buildPriceColumn(
                  price, context, language, () => _onAdsClick(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceColumn(String price, BuildContext context,
      Languages language, Function onBtnClick) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
            child: Text(
              price,
              style: priceStyle,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: [
                Text(
                  language.oneTimePayment,
                  style: oneTimePaymentStyle,
                ),
              ],
            ),
          ),
          _buildBuyButton(onBtnClick),
        ],
      ),
    );
  }

  Widget _buildBuyButton(Function onBtnClick) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Builder(
        builder: (_) => InkWell(
            onTap: () => onBtnClick(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                child: Container(
                  color: buttonColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Globals.instance.getLanguage().select,
                      style: buttonTextStyle,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildSvgImage(String imagePath) {
    return SvgPicture.asset(
      imagePath,
      height: 25.0,
    );
  }

  Widget _buildContentRow(BuildContext context, String text, IconData icon) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Icon(
            icon,
            color: payWallIconColor,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              text,
              style: settingsTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentHeaderRow(
      BuildContext context, String text, String imagePath) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
          child: _buildSvgImage(imagePath),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: settingsTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onPremiumClick(BuildContext context) async {
    await context.read<PurchasesCubit>().emitBuyPremium();
  }

  Future<void> _onCompatClick(BuildContext context) async {
    await context.read<PurchasesCubit>().emitBuyCompat();
  }

  Future<void> _onProfilesClick(BuildContext context) async {
    await context.read<PurchasesCubit>().emitBuyProfiles();
  }

  Future<void> _onAdsClick(BuildContext context) async {
    await context.read<PurchasesCubit>().emitBuyAdsFree();
  }

  Widget _buildDiscount(String discount) {
    return ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.035,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            Globals.instance.language.discount + ' $discount%',
            textAlign: TextAlign.center,
            style: discountTextStyle,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.yellow],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }

  Widget _compatibility(
      BuildContext context, Languages language, String price) {
    return SliverToBoxAdapter(
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContentHeaderRow(
                      context, language.compatibility, heart),
                  _buildContentRow(
                      context, language.getCompatReport, Icons.check_circle),
                ],
              ),
              _buildPriceColumn(
                  price, context, language, () => _onCompatClick(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profiles(BuildContext context, Languages language, String price) {
    return SliverToBoxAdapter(
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContentHeaderRow(context, language.profiles, profiles),
                  _buildContentRow(
                      context, language.addProfiles, Icons.check_circle),
                ],
              ),
              _buildPriceColumn(
                  price, context, language, () => _onProfilesClick(context)),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * -0.0043143, size.height * 1.0066000,
        size.width * 0.2819429, size.height);
    path.cubicTo(size.width * 0.3907429, size.height, size.width * 0.6083429,
        size.height, size.width * 0.7171429, size.height);
    path.quadraticBezierTo(
        size.width * 0.9986857, size.height * 0.9995000, size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
