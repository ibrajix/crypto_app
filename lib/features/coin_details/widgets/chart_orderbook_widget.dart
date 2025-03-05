import 'package:crypto_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/theme_provider.dart';

class ChartsOrderbookWidget extends ConsumerStatefulWidget {
  const ChartsOrderbookWidget({super.key});

  @override
  ConsumerState<ChartsOrderbookWidget> createState() =>
      _ChartsOrderbookWidgetState();
}

class _ChartsOrderbookWidgetState extends ConsumerState<ChartsOrderbookWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? greyBg : whiteShade,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorWeight: 0,
              indicatorPadding: EdgeInsets.all(0),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? cardColorDark : white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Text("Charts Content"),
                  Text("Orderbook Content"),
                  Text("Recent Trades Content"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
