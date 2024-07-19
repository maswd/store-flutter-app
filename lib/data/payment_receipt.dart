class PaymentReceiptData {
  final bool purchaseSuccess;
  final String paymentStatus;
  final int payablePrice;

  PaymentReceiptData.fromJson(Map<String, dynamic> json)
      : payablePrice = json["payable_price"],
        paymentStatus = json['payment_status'],
        purchaseSuccess = json['purchase_success'];
}
