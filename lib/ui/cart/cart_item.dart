import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/cart_item.dart';
import 'package:store/theme.dart';
import 'package:store/ui/widgets/image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.data,
    required this.onDeleteButtonClick,
    required this.onIncreaseButtonClick,
    required this.onDecreaseButtonClick,
  });

  final CartItemEntity data;
  final GestureTapCallback onDeleteButtonClick;
  final GestureTapCallback onIncreaseButtonClick;
  final GestureTapCallback onDecreaseButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            )
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: ImageLoadingService(
                        borderRadius: BorderRadius.circular(4),
                        imageUrl: data.product.imageUrl)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.product.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("تعداد"),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onIncreaseButtonClick,
                          icon: const Icon(CupertinoIcons.plus_rectangle),
                        ),
                        data.changeCountLoading
                            ? CupertinoActivityIndicator(
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            : Text(
                                data.count.toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                        IconButton(
                          onPressed: onDecreaseButtonClick,
                          icon: const Icon(CupertinoIcons.minus_rectangle),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      data.product.previousPrice.withPriceLabel,
                      style: const TextStyle(
                          fontSize: 12,
                          color: LightThemeColors.secondaryTextColor,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text(data.product.price.withPriceLabel)
                  ],
                )
              ],
            ),
          ),
          const DividerItem(),
          data.deleteButtonLoading
              ? const SizedBox(
                  height: 48,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : TextButton(
                  onPressed: onDeleteButtonClick,
                  child: const Text("حذف از سبد خرید"))
        ],
      ),
    );
  }
}

class DividerItem extends StatelessWidget {
  const DividerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.secondary.withOpacity(.1),
    );
  }
}
