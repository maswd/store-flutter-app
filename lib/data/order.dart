class CreateOrderResult {
  final int orderId;
  final String bankGatewayUrl;
  CreateOrderResult(this.orderId, this.bankGatewayUrl);
  CreateOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json["order_id"],
        bankGatewayUrl = json["bank_gateway_url"];
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

enum PaymentMethod {
  online,
  cashOnDelivery,
}
