import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/product.dart';
import 'package:store/data/repo/product_repository.dart';
import 'package:store/ui/list/bloc/product_list_bloc.dart';
import 'package:store/ui/product/product.dart';

class ProductListScreen extends StatefulWidget {
  final int sort;
  const ProductListScreen({super.key, required this.sort});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType { grid, list }

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ViewType viewType = ViewType.grid;

  @override
  void dispose() {
    bloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("کفش های ورزشی"),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (context) {
          bloc = ProductListBloc(productRepository)
            ..add(ProductListStarted(widget.sort));
          return bloc!;
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 1)),
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.2),
                          )
                        ]),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 260,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 24, bottom: 24),
                                child: Column(
                                  children: [
                                    Text(
                                      "انتخاب مرتب سازی",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: state.sortNames.length,
                                        itemBuilder: (context, index) {
                                          final selectedSortIndex = state.sort;
                                          return InkWell(
                                            onTap: () {
                                              bloc!.add(
                                                  ProductListStarted(index));
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 8, 16, 8),
                                              child: SizedBox(
                                                height: 32,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        state.sortNames[index]),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    if (index ==
                                                        selectedSortIndex)
                                                      Icon(
                                                        CupertinoIcons
                                                            .check_mark_circled_solid,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(CupertinoIcons.sort_down)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("مرتب سازی"),
                                      Text(
                                        ProductSort.name[state.sort],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    viewType = viewType == ViewType.grid
                                        ? ViewType.list
                                        : ViewType.grid;
                                  });
                                },
                                icon:
                                    const Icon(CupertinoIcons.square_grid_2x2)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: viewType == ViewType.grid ? 2 : 1,
                          childAspectRatio: .65,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final product = products[index];
                          return ProductItem(
                            product: product,
                            borderRadius: BorderRadius.zero,
                          );
                        }),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
