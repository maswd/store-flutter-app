import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernamecontroller =
      TextEditingController(text: "fudjkfhssad33sf555@gmail.com");
  final TextEditingController passwordcontroller =
      TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
          snackBarTheme:
              SnackBarThemeData(backgroundColor: themeData.colorScheme.primary),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  minimumSize:
                      WidgetStateProperty.all(const Size.fromHeight(56)),
                  foregroundColor: WidgetStateProperty.all(
                      themeData.colorScheme.secondary))),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: onBackground),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: onBackground.withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: themeData.colorScheme.secondary,
          body: BlocProvider<AuthBloc>(
            create: (context) {
              final bloc = AuthBloc(authRepository);
              bloc.stream.forEach((state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).pop();
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.exception.message)));
                }
              });
              bloc.add(AuthStarted());
              return bloc;
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 48,
                right: 48,
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthLoading ||
                      current is AuthInitial ||
                      current is AuthError;
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/nike_logo.png",
                        color: Colors.white,
                        width: 120,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        state.isLoginMode ? "خوش آمدید" : "ثبت نام",
                        style:
                            const TextStyle(color: onBackground, fontSize: 22),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.isLoginMode
                            ? "لطفاً وارد حساب کاربری خود شوید"
                            : "ایمیل و رمز عبور خود را وارد کنید ",
                        style:
                            const TextStyle(color: onBackground, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: usernamecontroller,
                        style: const TextStyle(color: onBackground),
                        decoration: const InputDecoration(
                          label: Text("آدرس ایمیل "),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _PasswordTextField(
                        onBackground: onBackground,
                        controller: passwordcontroller,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context).add(
                              AuthButtonIsClicked(
                                  username: usernamecontroller.text,
                                  password: passwordcontroller.text));
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator()
                            : Text(state.isLoginMode ? "ورود" : "ثبت  نام"),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthModeChangeIsClicked());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.isLoginMode
                                  ? "حساب کاربری ندارید؟"
                                  : "حساب کاربری دارید ؟",
                              style: TextStyle(
                                  color: onBackground.withOpacity(.7)),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              state.isLoginMode ? "ثبت نام" : "ورود",
                              style: TextStyle(
                                  color: themeData.colorScheme.primary,
                                  decorationColor:
                                      themeData.colorScheme.primary,
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.onBackground,
    required this.controller,
  });

  final Color onBackground;
  final TextEditingController controller;
  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obsecureText,
      style: TextStyle(color: widget.onBackground),
      decoration: InputDecoration(
          label: const Text("رمز عبور"),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obsecureText = !obsecureText;
              });
            },
            icon: Icon(
              obsecureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: widget.onBackground.withOpacity(0.6),
            ),
          )),
    );
  }
}
