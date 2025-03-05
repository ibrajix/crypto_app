import 'package:crypto_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppCheckbox extends ConsumerWidget {
  const AppCheckbox({
    required this.value,
    super.key,
    this.onSwitch,
    this.text,
  });

  final bool value;
  final ValueChanged<bool>? onSwitch; // Changed to ValueChanged<bool>
  final Widget? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        final newValue = !value;
        if (onSwitch != null) {
          onSwitch!(newValue);
        }
      },
      child: Row(
        children: [
          AnimatedContainer(
            height: 17,
            width: 17,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: value
                  ? Theme.of(context).cardColor
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: blackShade,
                width: 1.1,
              ),
            ),
            child: value
                ? const Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 13,
                      color: blackShade,
                    ),
                  )
                : const SizedBox(),
          ),
          if (text != null) ...[text!],
        ],
      ),
    );
  }
}
