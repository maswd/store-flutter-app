import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/repo/order_repository.dart';
import 'package:store/ui/cart/cart_item.dart';
import 'package:store/ui/order/bloc/order_history_bloc.dart';
import 'package:store/ui/widgets/image.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderHistoryBloc(orderRepository)..add(OrderHistoryStarted()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('سوابق سفارش'),
          ),
          body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
            builder: (context, state) {
              if (state is OrderHistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OrderHistorySuccess) {
                final orders = state.orders;
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Theme.of(context).dividerColor, width: 1)),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("شناسه سفارش"),
                                Text(order.id.toString()),
                              ],
                            ),
                          ),
                          const DividerItem(),
                          Container(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("مبلغ "),
                                Text(order.payablePrice.withPriceLabel),
                              ],
                            ),
                          ),
                          const DividerItem(),
                          SizedBox(
                            height: 132,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: order.items.length,
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              itemBuilder: (context, index) => Container(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                ),
                                child: ImageLoadingService(
                                    borderRadius: BorderRadius.circular(8),
                                    imageUrl: order.items[index].imageUrl),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text(' خطا در دریافت سفارش ها'));
              }
            },
          )),
    );
  }
}
