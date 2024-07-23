part of 'payment_receipt_bloc.dart';

abstract class PaymentReceiptEvent extends Equatable {
  const PaymentReceiptEvent();

  @override
  List<Object> get props => [];
}

class PaymentReseiptStarted extends PaymentReceiptEvent {
  final int orderId;

  const PaymentReseiptStarted(this.orderId);
  @override
  List<Object> get props => [orderId];
}
