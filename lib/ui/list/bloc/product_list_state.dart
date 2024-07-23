part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

final class ProductListLoading extends ProductListState {}

final class ProductListSuccess extends ProductListState {
  final List<ProductEntity> products;
  final int sort;
  final List<String> sortNames;
  const ProductListSuccess(this.products, this.sort, this.sortNames);
  @override
  List<Object> get props => [products, sort, sortNames];
}

final class ProductListError extends ProductListState {
  final AppException exception;

  const ProductListError(this.exception);

  @override
  List<Object> get props => [exception];
}