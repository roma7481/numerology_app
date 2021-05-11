import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/store_kit_wrappers.dart';
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
  StreamSubscription<List<PurchaseDetails>> _subscription;
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  List<ProductDetails> _productDetails;

  PurchasesCubit() : super(PurchasesInitLoading()) {
    emitInitPurchases();
  }

  List<ProductDetails> get productDetails => _productDetails;

  void emitInitPurchases() async {
    Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;

    _subscription = purchaseUpdates.listen((purchases) {
      _listenToPurchaseUpdated(purchases);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      emit(PurchasesInitError(error));
    });

    final bool available = await _connection.isAvailable();
    if (!available) {
      emit(PurchasesInitError(
          Exception('InAppPurchaseConnection not available')));
    }

    _productDetails = await _getProdDetails();
    _checkPastPurchases();
    emit(PurchasesInitSuccess(productDetails: _productDetails));
  }

  Future<List<ProductDetails>> _getProdDetails() async {
    final ProductDetailsResponse response =
        await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      emit(PurchasesInitError(Exception('no kIds found for products')));
    }
    return response.productDetails;
  }

  Future<void> restorePurchases() async {
    await _checkPastPurchases();
    emit(PurchasesRestored());
  }

  Future<void> _checkPastPurchases() async {
    PremiumController.instance.disablePremium();
    PremiumController.instance.disableCompat();
    PremiumController.instance.disableProfiles();
    PremiumController.instance.disableRemoveAds();

    final QueryPurchaseDetailsResponse response =
        await InAppPurchaseConnection.instance.queryPastPurchases();
    if (response.error != null) {
      emit(PurchasesInitError(Exception(response.error.message)));
    }
    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      if (purchase.status == PurchaseStatus.purchased) {
        PremiumController.instance.enablePremium();
      } else {
        _disablePremium(purchase.productID);
      }
    }
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
        _productDetails.where((product) => product.id == kId).first,
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

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        emit(PurchasesLoading());
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          InAppPurchaseConnection.instance.completePurchase(purchaseDetails);
          emit(PurchasesCanceled());
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          _enablePremium(purchaseDetails.productID);
          emit(PurchasesSuccess());
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
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
