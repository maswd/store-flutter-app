import 'package:flutter/material.dart';
import 'package:store/theme.dart';
import 'package:store/ui/cart/price_info.dart';
import 'package:store/ui/receipt/payment_receipt.dart';

class ShipingScreen extends StatelessWidget {
  final int shippingCost;
  final int totalPrice;
  final int payablePrice;

  const ShipingScreen(
      {super.key,
      required this.shippingCost,
      required this.totalPrice,
      required this.payablePrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(label: Text("نام و نام خانوادگی")),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(label: Text("شماره تماس")),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(label: Text("کد پستی")),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(label: Text("آدرس")),
              ),
              PriceInfo(
                  payablePrice: payablePrice,
                  shippingCost: shippingCost,
                  totalPrice: totalPrice),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: const ButtonStyle(
                          side: WidgetStatePropertyAll(BorderSide(
                              width: .2,
                              color: LightThemeColors.secondaryTextColor))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PaymentReceiptScreen(),
                        ));
                      },
                      child: const Text("پرداخت در محل")),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          backgroundColor: WidgetStatePropertyAll(
                              LightThemeColors.primaryColor)),
                      onPressed: () {},
                      child: const Text(
                        "پرداخت اینترنتی",
                      )),
                ],
              )
            ],
          )),
    );
  }
}
