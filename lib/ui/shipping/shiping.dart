import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/order.dart';
import 'package:store/data/repo/order_repository.dart';
import 'package:store/theme.dart';
import 'package:store/ui/cart/price_info.dart';
import 'package:store/ui/payment_webview.dart';
import 'package:store/ui/receipt/payment_receipt.dart';
import 'package:store/ui/shipping/bloc/shipping_bloc.dart';

class ShipingScreen extends StatefulWidget {
  final int shippingCost;
  final int totalPrice;
  final int payablePrice;

  ShipingScreen(
      {super.key,
      required this.shippingCost,
      required this.totalPrice,
      required this.payablePrice});

  @override
  State<ShipingScreen> createState() => _ShipingScreenState();
}

class _ShipingScreenState extends State<ShipingScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: "مسعود");

  final TextEditingController lastNameController =
      TextEditingController(text: "گرگانی");

  final TextEditingController phoneNumberController =
      TextEditingController(text: "09159594376");

  final TextEditingController postalController =
      TextEditingController(text: "1234567890");

  final TextEditingController addressController = TextEditingController(
      text: "خیابون خمینی 11 خیابون خمینی 11 خیابون خمینی 11 ");

  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(event.appException.message),
                ),
              );
            } else if (event is ShippingSuccess) {
              if (event.data.bankGatewayUrl.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentGatewayScreen(
                          bankGatewayUrl: event.data.bankGatewayUrl,
                        )));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentReceiptScreen(
                    orderId: event.data.orderId,
                  ),
                ));
              }
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(label: Text("نام ")),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: lastNameController,
                  decoration:
                      const InputDecoration(label: Text(" نام خانوادگی")),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(label: Text("شماره تماس")),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: postalController,
                  decoration: const InputDecoration(label: Text("کد پستی")),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(label: Text("آدرس")),
                ),
                PriceInfo(
                    payablePrice: widget.payablePrice,
                    shippingCost: widget.shippingCost,
                    totalPrice: widget.totalPrice),
                BlocBuilder<ShippingBloc, ShippingState>(
                  builder: (context, state) {
                    return state is ShippingLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                  style: const ButtonStyle(
                                      side: WidgetStatePropertyAll(BorderSide(
                                          width: .2,
                                          color: LightThemeColors
                                              .secondaryTextColor))),
                                  onPressed: () {
                                    BlocProvider.of<ShippingBloc>(context).add(
                                        ShippingCreateOrder(CreateOrderParams(
                                            firstNameController.text,
                                            lastNameController.text,
                                            phoneNumberController.text,
                                            addressController.text,
                                            postalController.text,
                                            PaymentMethod.cashOnDelivery)));
                                  },
                                  child: const Text("پرداخت در محل")),
                              const SizedBox(
                                width: 16,
                              ),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      foregroundColor:
                                          WidgetStatePropertyAll(Colors.white),
                                      backgroundColor: WidgetStatePropertyAll(
                                          LightThemeColors.primaryColor)),
                                  onPressed: () {
                                    BlocProvider.of<ShippingBloc>(context).add(
                                        ShippingCreateOrder(CreateOrderParams(
                                            firstNameController.text,
                                            lastNameController.text,
                                            phoneNumberController.text,
                                            addressController.text,
                                            postalController.text,
                                            PaymentMethod.online)));
                                  },
                                  child: const Text(
                                    "پرداخت اینترنتی",
                                  )),
                            ],
                          );
                  },
                )
              ],
            )),
      ),
    );
  }
}
