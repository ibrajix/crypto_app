import 'package:crypto_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/theme_provider.dart';
import '../widgets/home_header.dart';
import '../widgets/price_stats_section.dart';

class CoinDetailsScreen extends ConsumerStatefulWidget {
  const CoinDetailsScreen({super.key});

  @override
  ConsumerState createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends ConsumerState<CoinDetailsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
        backgroundColor: isDarkMode ? greyBg : whiteShade2,
        resizeToAvoidBottomInset: true,
        endDrawer: _buildEndDrawer(context),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(66),
          child: Header(),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: const [
            SizedBox(height: 8),
            PriceStatsSection(),
          ],
        ));
  }
}

Widget _buildEndDrawer(BuildContext context) {
  final drawerItems = [
    'Exchange',
    'Wallets',
    'Roqqu Hub',
    'Log out',
  ];

  final searchController = ValueNotifier<String>('');

  return Stack(
    children: [
      Positioned(
        top: 65,
        right: 10,
        child: Container(
          width: 214,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).shadowColor,
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search TextField
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    searchController.value = value.toLowerCase();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                ),
              ),

              // Filtered Drawer Items
              ValueListenableBuilder(
                valueListenable: searchController,
                builder: (context, searchValue, child) {
                  final filteredItems = drawerItems
                      .where(
                        (item) => item.toLowerCase().contains(searchValue),
                      )
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: filteredItems
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
