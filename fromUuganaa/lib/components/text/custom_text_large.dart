import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class CustomTextLarge extends StatelessWidget {
  const CustomTextLarge(this.text, {super.key, this.textStyle, this.textAlign});
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return Text(
          text,
          textAlign: textAlign,
          style: textStyle?.copyWith(
            color: mode == AdaptiveThemeMode.dark ? const Color(0xFFE2E2E2) : const Color(0xFF141414),
          ),
        );
      },
    );
  }
}
