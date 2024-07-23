import 'package:store/data/product.dart';

enum PaymentMethod {
  online,
  cashOnDelivery,
}

class CreateOrderParams {
  final String firstName;
  final String lastName;
  final String postalCode;
  final String phoneNumber;
  final String address;
  final PaymentMethod paymentMethod;

  CreateOrderParams(this.firstName, this.lastName, this.phoneNumber,
      this.address, this.postalCode, this.paymentMethod);
}

class CreateOrderResult {
  final int orderId;
  final String bankGatewayUrl;
  CreateOrderResult(this.orderId, this.bankGatewayUrl);
  CreateOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json["order_id"],
        bankGatewayUrl = json["bank_gateway_url"];
}

class OrderEntity {
  final int id;
  final int payablePrice;
  final List<ProductEntity> items;

  OrderEntity(this.id, this.payablePrice, this.items);

  OrderEntity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        payablePrice = json["payable"],
        items = (json["order_items"] as List)
            .map((item) => ProductEntity.fromJson(item["product"]))
            .toList();
}
