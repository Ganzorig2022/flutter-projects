import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AdaptiveTheme.of(context).theme == AdaptiveThemeMode.dark ? Colors.white.withOpacity(0.8) : const Color(0xFF141414).withOpacity(0.8),
        backgroundColor: AdaptiveTheme.of(context).theme == AdaptiveThemeMode.dark ? Colors.grey.shade900 : Colors.grey.shade400,
        strokeWidth: 1,
      ),
    );
  }
}
