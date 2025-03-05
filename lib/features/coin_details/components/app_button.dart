import 'package:crypto_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.height,
    this.width,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;
  final Color color;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        color: color,
        elevation: 0,
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
              color: white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
