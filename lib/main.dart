import 'package:crypto_app/constants/colors.dart';
import 'package:crypto_app/constants/strings.dart';
import 'package:crypto_app/features/coin_details/view/coin_details_screen.dart';
import 'package:crypto_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Crypto App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: fontFamily,
          cardColor: white),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          fontFamily: fontFamily,
          useMaterial3: true,
          cardColor: cardColorDark),
      themeMode: themeMode,
      home: const CoinDetailsScreen(),
    );
  }
}
