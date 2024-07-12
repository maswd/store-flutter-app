import 'package:flutter/material.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/data/repo/banner_repository.dart';
import 'package:store/data/repo/product_repository.dart';
import 'package:store/theme.dart';
import 'package:store/ui/auth/auth.dart';
import 'package:store/ui/home/home.dart';
import 'package:store/ui/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    productRepository.search("کفش").then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });
    const defaultTextStyle = TextStyle(
        fontFamily: "IranYekan", color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        dividerColor: Colors.grey.shade200,
        textTheme: TextTheme(
            // subtitle1
            titleMedium: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            // button
            labelLarge: defaultTextStyle,
            // body2
            bodyMedium: defaultTextStyle,
            // h6
            titleLarge: defaultTextStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 18),
            // caption
            bodySmall: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor)),
        colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onSecondary: Colors.white),
        useMaterial3: true,
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
