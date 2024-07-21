import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class CustomTextMedium extends StatelessWidget {
  const CustomTextMedium(this.text, {super.key, this.textStyle, this.textAlign, this.softWrap = true});
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return Text(
          text,
          textAlign: textAlign,
          softWrap: softWrap,
          maxLines: 4,
          style: textStyle?.copyWith(
            color: mode == AdaptiveThemeMode.dark ? const Color(0xFFAFAFAF) : const Color(0xFF565656),
          ),
        );
      },
    );
  }
}
