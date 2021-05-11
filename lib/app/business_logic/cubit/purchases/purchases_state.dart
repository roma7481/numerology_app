part of 'purchases_cubit.dart';

@immutable
abstract class PurchasesState {}

class PurchasesInitLoading extends PurchasesState {}

class PurchasesInitError extends PurchasesState {
  final Exception exception;

  PurchasesInitError(this.exception);
}

class PurchasesInitSuccess extends PurchasesState {
  final List<ProductDetails> productDetails;

  PurchasesInitSuccess({@required this.productDetails});
}

class PurchasesLoading extends PurchasesState {}

class PurchasesError extends PurchasesState {}

class PurchasesCanceled extends PurchasesState {}

class PurchasesSuccess extends PurchasesState {}

class PurchasesRestored extends PurchasesState {}
