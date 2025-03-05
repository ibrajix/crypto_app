import 'package:crypto_app/constants/colors.dart';
import 'package:crypto_app/constants/images.dart';
import 'package:crypto_app/features/coin_details/widgets/chart_orderbook_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../networking/binance/websocket_provider.dart';
import '../../../theme/theme_provider.dart';

class PriceStatsSection extends ConsumerStatefulWidget {
  const PriceStatsSection({super.key});

  @override
  ConsumerState<PriceStatsSection> createState() => _PriceStatsSectionState();
}

class _PriceStatsSectionState extends ConsumerState<PriceStatsSection> {
  final String _symbol = 'BTCUSDT';
  final String _interval = '1d';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(webSocketProvider.notifier)
          .connectToCandlestickStream(_symbol, _interval);
      ref.read(webSocketProvider.notifier).connectToOrderbookStream(_symbol);
    });
  }

  @override
  Widget build(BuildContext context) {
    final webSocketState = ref.watch(webSocketProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceInfo(webSocketState),
          const ChartsOrderbookWidget(),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(WebSocketState state) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    if (state.candlestickData == null) {
      return const Center(child: CircularProgressIndicator(color: black));
    }

    final candleData = state.candlestickData['k'];
    final openPrice = double.parse(candleData['o']);
    final closePrice = double.parse(candleData['c']);
    final priceChange = closePrice - openPrice;
    final percentChange = (priceChange / openPrice) * 100;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.btcUsdt,
                  width: 44,
                  height: 24,
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Text(
                        "BTC/USDT",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Text('\$${closePrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, color: mainGreen)),
              ],
            ),
            const SizedBox(height: 14),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatColumn(
                    icon: AppImages.clock,
                    label: '24h change',
                    value:
                        '${priceChange.toStringAsFixed(2)} ${priceChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(2)}%',
                    color: priceChange >= 0 ? mainGreen : mainRed,
                  ),
                  const SizedBox(width: 10),
                  _buildDivider(),
                  const SizedBox(width: 16),
                  _buildStatColumn(
                    icon: AppImages.lineUp,
                    label: '24h high',
                    value:
                        '${priceChange.toStringAsFixed(2)} ${priceChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(2)}%',
                    color: isDarkMode ? white : black,
                  ),
                  const SizedBox(width: 10),
                  _buildDivider(),
                  const SizedBox(width: 16),
                  _buildStatColumn(
                    icon: AppImages.lineDown,
                    label: '24h low',
                    value:
                        '${priceChange.toStringAsFixed(2)} ${priceChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(2)}%',
                    color: isDarkMode ? white : black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn({
    required String icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return SizedBox(
      width: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: blackShade),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 48,
      color: divider.withOpacity(.08),
    );
  }

  @override
  void dispose() {
    ref.read(webSocketProvider.notifier).dispose();
    super.dispose();
  }
}
