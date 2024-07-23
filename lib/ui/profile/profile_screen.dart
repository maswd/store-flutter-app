import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/data/auth_info.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/data/repo/cart_repository.dart';
import 'package:store/ui/auth/auth.dart';
import 'package:store/ui/cart/cart_item.dart';
import 'package:store/ui/favorites/favorite_screen.dart';
import 'package:store/ui/order/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("پروفایل"),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, authInfo, child) {
            final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 65,
                      height: 65,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 32, bottom: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).dividerColor, width: 1)),
                      child: Image.asset("assets/img/nike_logo.png")),
                  Text(isLogin ? authInfo.email : "کاربر میهمان"),
                  const SizedBox(height: 32),
                  const DividerItem(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FavoriteListScreen()));
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: const Row(
                        children: [
                          Icon(CupertinoIcons.heart),
                          SizedBox(
                            width: 16,
                          ),
                          Text("لیست علاقه مندی ها"),
                        ],
                      ),
                    ),
                  ),
                  const DividerItem(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  OrderHistoryScreen()));
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: const Row(
                        children: [
                          Icon(CupertinoIcons.cart),
                          SizedBox(
                            width: 16,
                          ),
                          Text("سوابق سفارش"),
                        ],
                      ),
                    ),
                  ),
                  const DividerItem(),
                  InkWell(
                    onTap: () {
                      if (isLogin) {
                        showDialog(
                          context: context,
                          useRootNavigator: true,
                          builder: (context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: Text(
                                  "خروج از حساب کاربری",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                content: Text(
                                  "آیا می خواهید از حساب خود خارج شوید ؟ ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("خیر")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        CartRepository.cartItemNotifier.value =
                                            0;
                                        authRepository.signOut();
                                      },
                                      child: const Text("بله")),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ));
                      }
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Row(
                        children: [
                          Icon(isLogin
                              ? CupertinoIcons.arrow_right_square
                              : CupertinoIcons.arrow_left_square),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(isLogin
                              ? "خروج از حساب کاربری"
                              : " ورود به حساب کاربری"),
                        ],
                      ),
                    ),
                  ),
                  const DividerItem(),
                ],
              ),
            );
          }),
    );
  }
}
