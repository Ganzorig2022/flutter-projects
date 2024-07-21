import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteGreenButton extends StatelessWidget {
  const WhiteGreenButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.padding = const EdgeInsets.all(16),
  });
  final String label;
  final void Function()? onPressed;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: mode == AdaptiveThemeMode.dark ? const Color(0xFF4CA92E) : Colors.white,
          ),
          child: CupertinoButton(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: mode == AdaptiveThemeMode.dark ? const Color(0xFFFFFFFF) : const Color(0xFF141414),
                fontSize: 15,
                height: 1.2,
              ),
            ),
            onPressed: onPressed,
            borderRadius: BorderRadius.circular(36),
          ),
        );
      },
    );
  }
}
