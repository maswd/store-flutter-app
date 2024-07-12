import 'package:store/data/product.dart';

class CartItemEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartItemEntity(this.product, this.id, this.count);
  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json),
        id = json['cart_item_id'],
        count = json['count'];
}
