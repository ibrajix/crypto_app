import 'package:crypto_app/constants/colors.dart';
import 'package:crypto_app/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/theme_provider.dart';
import '../providers/order_book_provider.dart';

class Orderbook extends ConsumerWidget {
  const Orderbook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final orderbook = ref.watch(orderbookProvider);

    // Sort asks (sell orders) and bids (buy orders)
    final asks = orderbook.where((entry) => !entry.isBid).toList();
    final bids = orderbook.where((entry) => entry.isBid).toList();

    // Sort in descending order
    asks.sort((a, b) => b.price.compareTo(a.price));
    bids.sort((a, b) => b.price.compareTo(a.price));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xff353945)
                          : const Color(0xffCFD3D8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SvgPicture.asset(AppImages.select1),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(),
                    child: SvgPicture.asset(AppImages.select3),
                  ),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: const BoxDecoration(),
                    child: SvgPicture.asset(AppImages.select2),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xff353945)
                      : const Color(0xffCFD3D8),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      '10',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: isDarkMode ? blackShade : blackShade,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '(USDT)',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDarkMode ? blackShade : blackShade,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amounts',
                    style: TextStyle(
                      color: isDarkMode ? blackShade : blackShade,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '(BTC)',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDarkMode ? blackShade : blackShade,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Text(
                'Total',
                style: TextStyle(
                  color: isDarkMode ? blackShade : blackShade,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        //order books here
        if (orderbook.isNotEmpty) ...[
          Column(
            children: List.generate(
              asks.length > 5 ? 5 : asks.length,
              (index) => Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: const Color(0xffFF6838).withOpacity(.15),
                      height: 28,
                      width: (asks[index].price * asks[index].amount) / 100,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          asks[index].price.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Color(0xffFF6838),
                          ),
                        ),
                        Text(
                          asks[index].amount.toStringAsFixed(3),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          (asks[index].price * asks[index].amount)
                              .toStringAsFixed(2),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Middle section with prices
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                asks.isNotEmpty ? asks[1].price.toStringAsFixed(2) : '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff25C26E),
                ),
              ),
              const SizedBox(width: 13),
              Icon(
                Icons.arrow_upward_rounded,
                size: 18,
                color: isDarkMode ? Colors.white : const Color(0xff25C26E),
              ),
              const SizedBox(width: 13),
              Text(
                bids.isNotEmpty ? bids[1].price.toStringAsFixed(2) : '',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Bids (Buy Orders)
          Expanded(
            child: Column(
              children: List.generate(
                bids.length > 5 ? 5 : bids.length,
                (index) => Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        color: const Color(0xff25C26E).withOpacity(.15),
                        height: 24,
                        width: (bids[index].price * bids[index].amount) / 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              bids[index].price.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Color(0xff25C26E),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              bids[index].amount.toStringAsFixed(3),
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (bids[index].price * bids[index].amount)
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
