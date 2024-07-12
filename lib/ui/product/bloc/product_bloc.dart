import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/common/exceptions.dart';
import 'package:store/data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;

  ProductBloc(this.cartRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClick) {
        try {
          emit(ProductAddToCartButttonLoading());
          await Future.delayed(Duration(seconds: 2));
          final result =await cartRepository.add(event.productId);
          emit(ProductAddToCartSuccess());
        } catch (e) {
          emit(ProductAddToCartButttonError(AppException()));
        }
      }
    });
  }
}
