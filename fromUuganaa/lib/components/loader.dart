import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return Container(
          color: mode == AdaptiveThemeMode.dark ? const Color(0xFF141414).withOpacity(0.8) : Colors.white.withOpacity(0.8),
          child: Center(
            child: CircularProgressIndicator(
              color: mode == AdaptiveThemeMode.dark ? Colors.white.withOpacity(0.8) : const Color(0xFF141414).withOpacity(0.8),
              backgroundColor: mode == AdaptiveThemeMode.dark ? Colors.grey.shade900 : Colors.grey.shade400,
              strokeWidth: 2,
            ),
          ),
        );
      },
    );
  }
}
