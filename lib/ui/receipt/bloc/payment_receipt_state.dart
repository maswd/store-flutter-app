part of 'payment_receipt_bloc.dart';

sealed class PaymentReceiptState extends Equatable {
  const PaymentReceiptState();

  @override
  List<Object> get props => [];
}

final class PaymentReceiptInitial extends PaymentReceiptState {}

final class PaymentReceiptLoading extends PaymentReceiptState {}

final class PaymentReceiptSuccess extends PaymentReceiptState {
  final PaymentReceiptData peymentReceiptData;

  const PaymentReceiptSuccess(this.peymentReceiptData);

  @override
  List<Object> get props => [peymentReceiptData];
}

class PaymentReceiptError extends PaymentReceiptState {
  final AppException exception;

  const PaymentReceiptError(this.exception);
  @override
  List<Object> get props => [exception];
}
