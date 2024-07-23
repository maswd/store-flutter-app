import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/favorite_manager.dart';
import 'package:store/data/product.dart';
import 'package:store/theme.dart';
import 'package:store/ui/product/details.dart';
import 'package:store/ui/widgets/image.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("لیست علاقه مندی ها"),
      ),
      body: ValueListenableBuilder<Box<ProductEntity>>(
          valueListenable: favoriteManager.listenble,
          builder: (context, box, child) {
            final products = box.values.toList();
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 100),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 110,
                          height: 110,
                          child: ImageLoadingService(
                            imageUrl: product.imageUrl,
                            borderRadius: BorderRadius.circular(8),
                          )),
                      Expanded(
                          child: InkWell(
                        onLongPress: () async{
                            favoriteManager.delete(product);

                        },
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(
                                        color:
                                            LightThemeColors.primaryTextColor),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Text(product.previousPrice.withPriceLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough)),
                              Text(product.price.withPriceLabel)
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
