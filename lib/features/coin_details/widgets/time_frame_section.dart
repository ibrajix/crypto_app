import 'package:crypto_app/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../theme/theme_provider.dart';

final timeframeProvider =
    StateNotifierProvider<TimeframeNotifier, String>((ref) {
  return TimeframeNotifier();
});

class TimeframeNotifier extends StateNotifier<String> {
  TimeframeNotifier() : super('1H');

  void selectTimeframe(String timeframe) {
    state = timeframe;
  }
}

class TimeframeSection extends ConsumerWidget {
  const TimeframeSection({
    required this.onSelected,
    super.key,
  });

  final Function(String) onSelected;

  static const List<String> _timeframes = [
    '1H',
    '2H',
    '4H',
    '1D',
    '1W',
    '1M',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTimeframe = ref.watch(timeframeProvider);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTimeLabel(context, isDarkMode),
            const SizedBox(width: 5),
            ..._buildTimeframeButtons(
                context, ref, currentTimeframe, isDarkMode),
            _buildAdditionalControls(context, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeLabel(BuildContext context, bool isDarkMode) {
    return const Text(
      'Time',
      style: TextStyle(fontSize: 14),
    );
  }

  List<Widget> _buildTimeframeButtons(BuildContext context, WidgetRef ref,
      String currentTimeframe, bool isDarkMode) {
    return _timeframes.map((timeframe) {
      return _buildTimeframeButton(
          context, ref, timeframe, currentTimeframe, isDarkMode);
    }).toList();
  }

  Widget _buildTimeframeButton(BuildContext context, WidgetRef ref,
      String timeframe, String currentTimeframe, bool isDarkMode) {
    return InkWell(
      onTap: () {
        onSelected(timeframe);
        ref.read(timeframeProvider.notifier).selectTimeframe(timeframe);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 40,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: currentTimeframe == timeframe
              ? isDarkMode
                  ? greyShade2
                  : greyShade
              : Colors.transparent,
        ),
        child: Center(
          child: Text(
            timeframe,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalControls(BuildContext context, bool isDarkMode) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(AppImages.caretDown),
              ),
              _buildVerticalDivider(),
              const SizedBox(width: 5),
              SvgPicture.asset(
                AppImages.chart,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        _buildVerticalDivider(),
        const SizedBox(width: 6),
        const Text(
          'Fx Indicators',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 6)
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 25,
      color: divider.withOpacity(.08),
    );
  }
}
