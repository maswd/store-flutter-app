part of 'shipping_bloc.dart';

abstract class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

final class ShippingInitial extends ShippingState {}

class ShippingLoading extends ShippingState {}

class ShippingError extends ShippingState {
  final AppException appException;

  const ShippingError(this.appException);

  @override
  List<Object> get props => [appException];
}

class ShippingSuccess extends ShippingState {
  final CreateOrderResult data;

  const ShippingSuccess(this.data);
  @override
  List<Object> get props => [data];
}
