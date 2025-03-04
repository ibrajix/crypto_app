import 'package:crypto_app/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/theme_provider.dart';

class Header extends ConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          isDarkMode ? AppImages.logo : AppImages.logoDark,
        ),
        actions: [
          Image.asset(
            AppImages.user,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16),
          SvgPicture.asset(
            AppImages.globe,
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => Scaffold.of(context).openEndDrawer(),
            child: SvgPicture.asset(
              AppImages.menu,
            ),
          ),
          const SizedBox(width: 16),
          const ThemeSwitch(),
          const SizedBox(width: 26),
        ],
      ),
    );
  }
}

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return GestureDetector(
      onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
      child: Container(
        width: 50,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isDarkMode ? Colors.white24 : Colors.black12,
        ),
        child: Stack(
          alignment: isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            Positioned(
              left: isDarkMode ? null : 2,
              right: isDarkMode ? 2 : null,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Positioned(
              left: 5,
              child: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
