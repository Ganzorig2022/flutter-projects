import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';

class BlackWhiteButton extends StatelessWidget {
  const BlackWhiteButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.padding = const EdgeInsets.all(16),
    this.borderColor = const Color(0xFFF4F7F2),
    this.lightColor = const Color(0xFF141414),
    this.darkColor = const Color(0xFFF4F7F2),
  });
  final String label;
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final Color borderColor;
  final Color darkColor;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: borderColor, width: 1),
            color: mode == AdaptiveThemeMode.dark ? darkColor : lightColor,
          ),
          child: CupertinoButton(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: mode == AdaptiveThemeMode.dark ? const Color(0xFF141414) : const Color(0xFFFFFFFF),
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
