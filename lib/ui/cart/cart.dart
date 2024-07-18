import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/common/utils.dart';
import 'package:store/data/cart_item.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/data/repo/cart_repository.dart';
import 'package:store/ui/auth/auth.dart';

import 'package:store/ui/cart/bloc/cart_bloc.dart';
import 'package:store/ui/cart/cart_item.dart';
import 'package:store/ui/cart/price_info.dart';
import 'package:store/ui/shipping/shiping.dart';
import 'package:store/ui/widgets/empty_state.dart';
import 'package:store/ui/widgets/image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  StreamSubscription? stateStreamSubscription;
  final RefreshController _refreshController = RefreshController();
  bool stateIsSuccess = false;
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    stateStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: stateIsSuccess,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 48, right: 48),
          child: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                final state = cartBloc!.state;
                if (state is CartSuccess) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShipingScreen(
                      shippingCost: state.cartResponse.shippingCost,
                      payablePrice: state.cartResponse.payablePrice,
                      totalPrice: state.cartResponse.totalPrice,
                    ),
                  ));
                }
              },
              label: const Text("پرداخت")),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبد خرید "),
      ),
      body: BlocProvider<CartBloc>(create: (context) {
        final bloc = CartBloc(cartRepository);
        stateStreamSubscription = bloc.stream.listen((state) {
          setState(() {
            stateIsSuccess = state is CartSuccess;
          });

          if (_refreshController.isRefresh) {
            if (state is CartSuccess) {
              _refreshController.refreshCompleted();
            } else if (state is CartError) {
              _refreshController.refreshFailed();
            }
          }
        });
        cartBloc = bloc;
        bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
        return bloc;
      }, child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartError) {
          return Center(
            child: Text(state.exception.message),
          );
        } else if (state is CartSuccess) {
          return SmartRefresher(
            header: const ClassicHeader(
              completeText: "با موفقیت انجام شد",
              refreshingText: "در حال بروز رسانی",
              idleText: 'برای بروزرسانی پایین بکشید',
              releaseText: "رها کنید",
              failedText: "خطای نامشخص",
              spacing: 5,
            ),
            controller: _refreshController,
            onRefresh: () {
              cartBloc?.add(CartStarted(AuthRepository.authChangeNotifier.value,
                  isRefreshing: true));
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: state.cartResponse.cartItems.length + 1,
              itemBuilder: (context, index) {
                debugPrint(index.toString());
                debugPrint(state.cartResponse.cartItems.length.toString());

                if (index < state.cartResponse.cartItems.length) {
                  final data = state.cartResponse.cartItems[index];
                  return CartItem(
                    data: data,
                    onDecreaseButtonClick: () {
                      if (data.count > 1) {
                        cartBloc?.add(CartDecreaseCountButtonClicked(data.id));
                      }
                    },
                    onIncreaseButtonClick: () {
                      cartBloc?.add(CartIncreaseCountButtonClicked(data.id));
                    },
                    onDeleteButtonClick: () {
                      cartBloc?.add(CartDeleteButtonClicked(data.id));
                    },
                  );
                } else {
                  return PriceInfo(
                    payablePrice: state.cartResponse.payablePrice,
                    shippingCost: state.cartResponse.shippingCost,
                    totalPrice: state.cartResponse.totalPrice,
                  );
                }
              },
            ),
          );
        } else if (state is CartAuthRequired) {
          return EmptyView(
              message: "برای مشاهده ی سبد خرید ابتدا وارد حساب کاربری خود شوید",
              callToAction: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary)),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen()));
                  },
                  child: Text("ورود به حساب کاربری",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary))),
              image: SvgPicture.asset(
                'assets/img/auth_required.svg',
                width: 140,
              ));
        } else if (state is CartEmpty) {
          return EmptyView(
              message: "تاکنون هیچ محصولی به سبد خرید خود اضافه نکرده اید",
              image: SvgPicture.asset(
                'assets/img/empty_cart.svg',
                width: 200,
              ));
        } else {
          throw Exception("current cart state is not valid");
        }
      })
          //  ValueListenableBuilder<AuthInfo?>(
          //   valueListenable: AuthRepository.authChangeNotifier,
          //   builder: (context, authState, child) {
          //     bool isAuthenticated =
          //         authState != null && authState!.accessToken.isNotEmpty;
          //     return SizedBox(
          //       width: MediaQuery.of(context).size.width,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(isAuthenticated
          //               ? "خوش امدید "
          //               : "لطفا وارد حساب کاربری خود شوید "),
          //           isAuthenticated
          //               ? ElevatedButton(
          //                   onPressed: () {
          //                     authRepository.signOut();
          //                   },
          //                   child: const Text("خروج از حساب "))
          //               : ElevatedButton(
          //                   onPressed: () {
          //                     Navigator.of(context, rootNavigator: true)
          //                         .push(MaterialPageRoute(
          //                       builder: (context) => const AuthScreen(),
          //                     ));
          //                   },
          //                   child: const Text("ورود"),
          //                 ),
          //           ElevatedButton(
          //               onPressed: () async {
          //                 await authRepository.refreshToken();
          //               },
          //               child: const Text("refreshToken"))
          //         ],
          //       ),
          //     );
          //   },
          ),
    );
  }
}
