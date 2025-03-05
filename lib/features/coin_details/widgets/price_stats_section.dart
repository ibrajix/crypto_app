import 'package:crypto_app/constants/colors.dart';
import 'package:crypto_app/constants/images.dart';
import 'package:crypto_app/features/coin_details/components/app_loader.dart';
import 'package:crypto_app/features/coin_details/widgets/chart_orderbook_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../networking/binance/websocket_provider.dart';
import '../../../theme/theme_provider.dart';
import '../components/app_button.dart';
import 'order_bottom_sheet.dart';

class PriceStatsSection extends ConsumerStatefulWidget {
  const PriceStatsSection({super.key});

  @override
  ConsumerState<PriceStatsSection> createState() => _PriceStatsSectionState();
}

class _PriceStatsSectionState extends ConsumerState<PriceStatsSection>
    with SingleTickerProviderStateMixin {
  final String _symbol = 'BTCUSDT';
  final String _interval = '1d';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          const SizedBox(height: 8),
          _buildOpenOrdersTradeHistory(),
          const SizedBox(height: 8),
          _buildBuySellSection()
        ],
      ),
    );
  }

  Widget _buildPriceInfo(WebSocketState state) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    if (state.candlestickData == null) {
      return const Center(child: AppLoader());
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

  Widget _buildBuySellSection() {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? cardColorDark : white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton(
                    title: 'Buy',
                    onPressed: () {
                      openBottomSheet(context, OrderMode.buy);
                    },
                    color: mainGreen,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    title: 'Sell',
                    onPressed: () {
                      openBottomSheet(context, OrderMode.sell);
                    },
                    color: mainRed,
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildOpenOrdersTradeHistory() {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDarkMode ? cardColorDark : white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Container(
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
                  Tab(text: 'Open Orders'),
                  Tab(text: 'Positions'),
                  Tab(text: 'Order History'),
                ],
              ),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? cardColorDark : white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox(
              height: 400,
              child: TabBarView(controller: _tabController, children: const [
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No Open Orders",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No Open Positions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No Order History",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
              ]),
            )),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 48,
      color: divider.withOpacity(.08),
    );
  }

  void openBottomSheet(BuildContext context, OrderMode orderMode) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: isDarkMode ? const Color(0xff20252B) : white,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext buildContext) {
        return OrderBottomSheet(orderMode: orderMode);
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    ref.read(webSocketProvider.notifier).dispose();
    super.dispose();
  }
}
