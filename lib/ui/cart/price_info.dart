import 'package:flutter/material.dart';
import 'package:store/common/utils.dart';
import 'package:store/theme.dart';
import 'package:store/ui/cart/cart_item.dart';

class PriceInfo extends StatelessWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  const PriceInfo(
      {super.key,
      required this.payablePrice,
      required this.shippingCost,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
          child: Text(
            "جزئیات خرید",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1)),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ کل خرید'),
                    RichText(
                        text: TextSpan(
                            text: totalPrice.separateByComma,
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(color: LightThemeColors.secondaryColor),
                            children: const [
                          TextSpan(
                              text: ' تومان', style: TextStyle(fontSize: 10))
                        ]))
                  ],
                ),
              ),
              const DividerItem(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    Text(shippingCost.withPriceLabel),
                  ],
                ),
              ),
              const DividerItem(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                      text: TextSpan(
                        text: payablePrice.separateByComma,
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
