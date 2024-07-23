import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/favorite_manager.dart';
import 'package:store/data/product.dart';
import 'package:store/ui/product/details.dart';
import 'package:store/ui/widgets/image.dart';

class ProductItem extends StatefulWidget {
  const ProductItem(
      {super.key,
      required this.product,
      required this.borderRadius,
      this.itemHeight = 189,
      this.itemWidth = 176});

  final ProductEntity product;
  final BorderRadius borderRadius;

  final double itemHeight;
  final double itemWidth;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          borderRadius: widget.borderRadius,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                    product: widget.product,
                  ))),
          child: SizedBox(
            width: widget.itemWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: .93,
                      child: ImageLoadingService(
                        imageUrl: widget.product.imageUrl,
                        borderRadius: widget.borderRadius,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: InkWell(
                        onTap: () {
                          if (!favoriteManager.isFavorite(widget.product)) {
                            favoriteManager.addFavorite(widget.product);
                          } else {
                            favoriteManager.delete(widget.product);
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ValueListenableBuilder(
                              valueListenable: favoriteManager.listenble,
                              builder: (context, box, child) {
                                return Icon(
                                  favoriteManager.isFavorite(widget.product)
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  size: 20,
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    widget.product.previousPrice.withPriceLabel,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(widget.product.price.withPriceLabel),
                ),
              ],
            ),
          ),
        ));
  }
}
