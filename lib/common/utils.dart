import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const defaultScrollPhysics = BouncingScrollPhysics();
const defaultFontFamily = "IranYekan";

extension PriceLabel on int {
  String get withPriceLabel => this > 0 ? '$separateByComma تومان' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
