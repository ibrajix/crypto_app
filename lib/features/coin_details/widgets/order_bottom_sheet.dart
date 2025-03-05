import 'package:crypto_app/constants/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../theme/theme_provider.dart';
import '../components/app_button.dart';
import '../components/app_check_box.dart';
import '../components/input_field.dart';

// Enum to define order modes
enum OrderMode { buy, sell }

class OrderBottomSheet extends ConsumerWidget {
  final OrderMode orderMode;

  const OrderBottomSheet({super.key, required this.orderMode});

  final List<String> options = const [
    'Limit',
    'Market',
    'Stop-Limit',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(actionBottomSheetProvider);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    // Dynamically set initial selected value based on order mode
    final initialSelectedValue = orderMode == OrderMode.buy ? 0 : 1;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 34, 30, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  CupertinoSlidingSegmentedControl(
                    backgroundColor: isDarkMode
                        ? black.withOpacity(.16)
                        : const Color(0xffF1F1F1),
                    thumbColor: isDarkMode ? const Color(0xff21262C) : white,
                    padding: const EdgeInsets.all(3),
                    groupValue: state.selectedValue ?? initialSelectedValue,
                    children: {
                      0: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: Text('Buy'),
                        ),
                      ),
                      1: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: Text('Sell'),
                        ),
                      ),
                    },
                    onValueChanged: (value) {
                      ref
                          .read(actionBottomSheetProvider.notifier)
                          .setSelectedValue(value!);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...options.map(
                  (e) => InkWell(
                    onTap: () {
                      ref
                          .read(actionBottomSheetProvider.notifier)
                          .setSelectedOption(e);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: state.selectedOption == e
                            ? isDarkMode
                                ? const Color(0xff555C63)
                                : const Color(0xffCFD3D8)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                              fontSize: 14, color: isDarkMode ? white : black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InputField(
              hintText: 'Limit price',
              suffixText: '0.00 USD',
              controller: state.limitPriceController,
            ),
            const SizedBox(height: 16),
            InputField(
              hintText: 'Amount',
              suffixText: '0.00 USD',
              controller: state.amountController,
            ),
            const SizedBox(height: 16),
            InputField(
              isReadOnly: true,
              hintText: 'Type',
              suffixText: 'Good till cancelled',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            AppCheckbox(
              value: state.postOnly,
              onSwitch: (val) {
                ref
                    .read(actionBottomSheetProvider.notifier)
                    .togglePostOnly(val);
              },
              text: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text('Post Only'),
                    SizedBox(width: 6),
                    Icon(Icons.info_outline_rounded, size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '0.00',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff483BEB),
                      Color(0xff7847E1),
                      Color(0xffDD568D),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Text(
                    state.selectedValue == 0 ? 'Buy BTC' : 'Sell BTC',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 15),
            Divider(color: black.withOpacity(.1), thickness: 1),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total account value',
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  children: [
                    const Text(
                      'NGN',
                      style: TextStyle(fontSize: 12),
                    ),
                    SvgPicture.asset(AppImages.caretDown),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('0.00',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Open Orders',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(
                  'Available',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0.00',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text('0.00',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 32),
            AppButton(
              title: 'Deposit',
              onPressed: () {},
              color: const Color(0xff2764FF),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionBottomSheetState {
  int? selectedValue;
  String selectedOption = 'Limit';
  bool postOnly = true;
  final TextEditingController limitPriceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
}

class ActionBottomSheetNotifier extends StateNotifier<ActionBottomSheetState> {
  ActionBottomSheetNotifier() : super(ActionBottomSheetState());

  void setSelectedValue(int value) {
    state = ActionBottomSheetState()
      ..selectedValue = value
      ..selectedOption = state.selectedOption
      ..postOnly = state.postOnly;
  }

  void setSelectedOption(String option) {
    state = ActionBottomSheetState()
      ..selectedOption = option
      ..selectedValue = state.selectedValue
      ..postOnly = state.postOnly;
  }

  void togglePostOnly(bool value) {
    state = ActionBottomSheetState()
      ..postOnly = value
      ..selectedValue = state.selectedValue
      ..selectedOption = state.selectedOption;
  }
}

// Provider for the ActionBottomSheet
final actionBottomSheetProvider =
    StateNotifierProvider<ActionBottomSheetNotifier, ActionBottomSheetState>(
  (ref) => ActionBottomSheetNotifier(),
);
