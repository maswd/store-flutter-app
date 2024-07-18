import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget? callToAction;
  final Widget image;

  const EmptyView(
      {super.key,
      required this.message,
      this.callToAction,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        Padding(
          padding: const EdgeInsets.fromLTRB(48, 24, 48, 16),
          child: Text(
              textAlign: TextAlign.center,
              message,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(height: 1.5)),
        ),
        if (callToAction != null) callToAction!,
      ],
    );
  }
}
