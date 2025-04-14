import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:meta/meta.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';

part 'purchases_state.dart';

const String premiumKid = 'numerology_premium';
const String compatKid = 'numerology_compatibility';
const String profileKid = 'numerology_profiles';
const String adsKid = 'numerology_remove_ads';

const Set<String> _kIds = {
  premiumKid,
  compatKid,
  profileKid,
  adsKid,
};

class PurchasesCubit extends Cubit<PurchasesState> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  InAppPurchase _connection = InAppPurchase.instance;
  List<ProductDetails>? _productDetails;
  var numTries = 0;

  var purchaseNotAvailable = Exception('InAppPurchaseConnection not available');
  var productNotFound = Exception('no kIds found for products');

  PurchasesCubit() : super(PurchasesLoading()) {
    emitInitPurchases();
  }

  List<ProductDetails>? get productDetails => _productDetails;

  void emitInitPurchases() async {
    Stream purchaseUpdates = _connection.purchaseStream;

    _subscription = purchaseUpdates.listen((purchases) {
      _listenToPurchaseUpdated(purchases);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      emit(PurchasesInitFailed(error));
    }) as StreamSubscription<List<PurchaseDetails>>;

    final bool available = await _connection.isAvailable();
    if (!available) {
      emit(PurchasesInitFailed(purchaseNotAvailable));
    }

    _productDetails = await _getProdDetails();
    await _connection.restorePurchases();
    emit(PurchasesReady(productDetails: _productDetails));
  }

  void retryInitPurchase(){
    if(numTries < 3){
      emitInitPurchases();
      numTries++;
    }
  }

  void resetNumberPurchaseInitTries(){
    numTries = 0;
  }

  Future<void> emitBuyPremium() async {
    await _emitBuyPremiumProduct(premiumKid);
  }

  Future<void> emitBuyCompat() async {
    await _emitBuyPremiumProduct(compatKid);
  }

  Future<void> emitBuyProfiles() async {
    await _emitBuyPremiumProduct(profileKid);
  }

  Future<void> emitBuyAdsFree() async {
    await _emitBuyPremiumProduct(adsKid);
  }

  Future<void> _emitBuyPremiumProduct(String kId) async {
    try{
      PurchaseParam purchaseParam = PurchaseParam(
        productDetails:
        _productDetails!.where((product) => product.id == kId).first,
        applicationUserName: null,
      );

      await _connection.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e){
      var transactions = await SKPaymentQueueWrapper().transactions();
      transactions.forEach((skPaymentTransactionWrapper) {
        SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
      });
    }
  }

  Future<List<ProductDetails>> _getProdDetails() async {
    final ProductDetailsResponse response = await _connection.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      emit(PurchasesInitFailed(productNotFound));
    }
    return response.productDetails;
  }

  Future<void> restorePurchases() async {
    await _connection.restorePurchases();
    emit(PurchasesRestored());
  }


  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        emit(PurchasesLoading());
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _disablePremium(purchaseDetails.productID);
          emit(PurchasesError());
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          _disablePremium(purchaseDetails.productID);
          emit(PurchasesCanceled());
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          _enablePremium(purchaseDetails.productID);
          emit(PurchasesSuccess());
        }  else if (purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.error != null) {
            PremiumController.instance.disablePremium();
            emit(PurchasesError());
          }
          _verifyPurchase(purchaseDetailsList);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _connection.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> _verifyPurchase(List<PurchaseDetails> purchaseDetails) async {
    for (PurchaseDetails purchase in purchaseDetails) {
      if(_kIds.contains(purchase.productID)){
        _enablePremium(purchase.productID);
        emit(PurchasesSuccess());
      } else {
        _disablePremium(purchase.productID);
        emit(PurchasesError());
      }
    }
  }


  void _enablePremium(String productID) {
    switch (productID) {
      case premiumKid:
        PremiumController.instance.enablePremium();
        break;
      case compatKid:
        PremiumController.instance.enableCompat();
        break;
      case profileKid:
        PremiumController.instance.enableProfiles();
        break;
      case adsKid:
        PremiumController.instance.enableRemoveAds();
        break;
      default:
        break;
    }
  }

  void _disablePremium(String productID) {
    switch (productID) {
      case premiumKid:
        PremiumController.instance.disablePremium();
        break;
      case compatKid:
        PremiumController.instance.disableCompat();
        break;
      case profileKid:
        PremiumController.instance.disableProfiles();
        break;
      case adsKid:
        PremiumController.instance.disableRemoveAds();
        break;
      default:
        break;
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
