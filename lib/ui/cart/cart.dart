import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/data/auth_info.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/ui/auth/auth.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("سبد خرید "),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authState, child) {
          bool isAuthenticated =
              authState != null && authState!.accessToken.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isAuthenticated
                    ? "خوش امدید "
                    : "لطفا وارد حساب کاربری خود شوید "),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.signOut();
                        },
                        child: const Text("خروج از حساب "))
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => const AuthScreen(),
                          ));
                        },
                        child: const Text("ورود"),
                      ),
                ElevatedButton(
                    onPressed: () async {
                      await authRepository.refreshToken();
                    },
                    child: const Text("refreshToken"))
              ],
            ),
          );
        },
      ),
    );
  }
}
