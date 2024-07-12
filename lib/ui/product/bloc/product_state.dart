part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class ProductAddToCartButttonLoading extends ProductState {}

class ProductAddToCartButttonError extends ProductState {
  final AppException exception;

  const ProductAddToCartButttonError(this.exception);
  @override
  List<Object> get props => [exception];
}
class ProductAddToCartSuccess extends ProductState{}
