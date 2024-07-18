import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/theme.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("رسید پرداخت"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: themeData.dividerColor, width: 1),
            ),
            child: Column(
              children: [
                Text(
                  "پرداخت با موفیقت انجام شد",
                  style: themeData.textTheme.titleLarge!
                      .apply(color: themeData.colorScheme.primary),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "وضعیت سفارش",
                      style:
                          TextStyle(color: LightThemeColors.secondaryTextColor),
                    ),
                    Text(
                      "پرداخت شده",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Divider(
                  height: 32,
                  thickness: 1,
                  color: themeData.dividerColor,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "مبلغ",
                      style:
                          TextStyle(color: LightThemeColors.secondaryTextColor),
                    ),
                    Text(
                      "149 تومان ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("بازگشت به صفحه اصلی"),
              style: const ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  backgroundColor:
                      WidgetStatePropertyAll(LightThemeColors.primaryColor)))
        ],
      ),
    );
  }
}
