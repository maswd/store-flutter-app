import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatelessWidget {
  final String bankGatewayUrl;
  const PaymentGatewayScreen({super.key, required this.bankGatewayUrl});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "expertdevelopers.ir/payment?order_id=7762",
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
