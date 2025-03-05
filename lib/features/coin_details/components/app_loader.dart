import 'package:crypto_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLoader({this.size = 10, this.color = mainGreen, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
          strokeWidth: 2, color: color ?? Theme.of(context).primaryColor),
    );
  }
}
