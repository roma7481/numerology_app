import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/purchases/purchases_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchasesCubit, PurchasesState>(
      listener: (context, state) {
        if (state is PurchasesError) {
          _onPurchaseError();
        } else if (state is PurchasesCanceled) {
          _onCanceled();
        } else if (state is PurchasesSuccess) {
          _onSuccess();
        }
      },
      child: BlocBuilder<PurchasesCubit, PurchasesState>(
          builder: (context, state) {
        if (state is PurchasesInitLoading || state is PurchasesLoading) {
          return progressBar();
        } else if (state is PurchasesInitError) {
          return errorDialog();
        }
        if (state is PurchasesInitSuccess) {
          return _buildPageContent(context);
        }
        return _buildPageContent(context);
      }),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        title: _buildAppBarContent(),
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
                    _buildContentRow(context, language.goPremium, Icons.stars),
                    _buildLine(context),
                    _buildContentRow(
                        context, language.getCompatReport, Icons.check_circle),
                    _buildContentRow(
                        context, language.openForecast, Icons.check_circle),
                    _buildContentRow(context, language.unlimitedProfiles,
                        Icons.check_circle),
                    _buildContentRow(context, language.oneTimePayment,
                        Icons.monetization_on_outlined),
                    _buildContentRow(context, language.adsFree,
                        Icons.monetization_on_outlined),
                    _buildBuyButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBuyButton() {
    String price = context.read<PurchasesCubit>().price;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Builder(
        builder: (buttonContext) => InkWell(
            onTap: () => _onClick(buttonContext),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                child: Container(
                  color: buttonColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Globals.instance.getLanguage().buy + ' ' + price,
                      style: buttonTextStyle,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context, String text, IconData icon) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
          child: Icon(
            icon,
            color: settingsIconColor,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
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

  Padding _buildLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.68,
        color: cardLineColor,
      ),
    );
  }

  Future<void> _onClick(BuildContext context) async {
    await context.read<PurchasesCubit>().emitBuyProduct();
  }
}
