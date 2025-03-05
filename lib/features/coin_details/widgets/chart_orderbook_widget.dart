import 'package:candlesticks/candlesticks.dart';
import 'package:crypto_app/constants/colors.dart';
import 'package:crypto_app/features/coin_details/components/app_loader.dart';
import 'package:crypto_app/features/coin_details/widgets/order_book_widget.dart';
import 'package:crypto_app/features/coin_details/widgets/time_frame_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/images.dart';
import '../../../theme/theme_provider.dart';
import '../providers/chart_data_provider.dart';

class ChartsOrderbookWidget extends ConsumerStatefulWidget {
  const ChartsOrderbookWidget({super.key});

  @override
  ConsumerState<ChartsOrderbookWidget> createState() =>
      _ChartsOrderbookWidgetState();
}

class _ChartsOrderbookWidgetState extends ConsumerState<ChartsOrderbookWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedView = 'Trading view';
  ValueNotifier<String> currentTime = ValueNotifier('1m');
  Candle? candlestick;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final chartState = ref.watch(chartDataProvider);

    return Container(
      color: isDarkMode ? cardColorDark : white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? greyBg : whiteShade,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorWeight: 0,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: isDarkMode ? greyBgShade.withOpacity(0.05) : white,
                ),
                labelStyle: TextStyle(
                  color: isDarkMode ? white : greyBg,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Satoshi',
                ),
                unselectedLabelStyle: TextStyle(
                  color: isDarkMode ? white : blackShade,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Satoshi',
                ),
                splashBorderRadius: BorderRadius.circular(20),
                padding: const EdgeInsets.all(3),
                tabs: const [
                  Tab(text: 'Charts'),
                  Tab(text: 'Orderbook'),
                  Tab(text: 'Recent trades'),
                ],
              ),
            ),

            // Chart/Orderbook/Trades Content
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? cardColorDark : white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SizedBox(
                height: 400,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Builder(
                      builder: (context) {
                        if (chartState.isLoading) {
                          return const Center(
                            child: AppLoader(),
                          );
                        }

                        if (chartState.error != null) {
                          return Center(
                            child: Text(
                              'Error: ${chartState.error}',
                              style: const TextStyle(color: mainRed),
                            ),
                          );
                        }

                        // Convert CandleData back to Candle for Candlesticks widget
                        final candles = chartState.candles
                            .map((candleData) => candleData.toCandle())
                            .toList();

                        // Get the latest candle for OHLC display
                        final latestCandle =
                            candles.isNotEmpty ? candles.last : null;

                        return Column(
                          children: [
                            TimeframeSection(
                              onSelected: (timeframe) {
                                ref
                                    .read(chartDataProvider.notifier)
                                    .updateTimeframe(timeframe);
                              },
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: divider, thickness: 0.1),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedView = 'Trading view';
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 13),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: _selectedView == "Trading view"
                                          ? isDarkMode
                                              ? greyShade3
                                              : whiteShade2
                                          : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Trading view',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDarkMode ? white : greyBg,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedView = 'Depth';
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 13),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: _selectedView == 'Depth'
                                          ? isDarkMode
                                              ? greyShade3
                                              : whiteShade2
                                          : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Depth',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDarkMode ? white : greyBg,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  AppImages.expand,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: Candlesticks(
                                key: Key(
                                    chartState.symbol + chartState.interval),
                                candles: candles,
                                onLoadMoreCandles: () async {},
                                actions: [
                                  ToolBarAction(
                                    width: 20,
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: SvgPicture.asset(
                                        AppImages.arrowDown,
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                  // Symbol and OHLC action
                                  ToolBarAction(
                                    width: 250,
                                    onPressed: () {},
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Row(
                                          children: [
                                            Text(
                                              chartState.symbol,
                                              style: const TextStyle(
                                                fontSize: 9,
                                                color: blackShade,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            if (latestCandle != null) ...[
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'O ',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: blackShade,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: latestCandle.open
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: mainGreen,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'H ',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: blackShade,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: latestCandle.high
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: mainGreen,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'L ',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: blackShade,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: latestCandle.low
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: mainGreen,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'C ',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: blackShade,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: latestCandle.close
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: mainGreen,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Orderbook(),
                    const Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No Recent Trades",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// You'll need to define this class based on your specific implementation
class StreamValue {
  final String symbol;
  final String interval;

  StreamValue({required this.symbol, required this.interval});
}
