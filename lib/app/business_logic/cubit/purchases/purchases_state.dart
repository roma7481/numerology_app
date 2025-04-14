part of 'purchases_cubit.dart';

@immutable
abstract class PurchasesState {}

class PurchasesLoading extends PurchasesState {}

class PurchasesInitFailed extends PurchasesState {
  final Exception exception;

  PurchasesInitFailed(this.exception);
}

class PurchasesReady extends PurchasesState {
  final List<ProductDetails>? productDetails;

  PurchasesReady({required this.productDetails});
}

class PurchasesError extends PurchasesState {}

class PurchasesCanceled extends PurchasesState {}

class PurchasesSuccess extends PurchasesState {}

class PurchasesRestored extends PurchasesState {}