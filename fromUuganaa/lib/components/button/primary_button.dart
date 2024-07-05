import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.padding = const EdgeInsets.all(16),
    this.darkColor = const Color(0xFF4CA92E),
    this.lightColor = const Color(0xFF141414),
  });
  final String label;
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final Color darkColor;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return CupertinoButton(
          color: mode == AdaptiveThemeMode.dark ? darkColor : lightColor,
          disabledColor: const Color(0xFFA1A1A1),
          borderRadius: BorderRadius.circular(28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, height: 1.2),
              ),
            ],
          ),
          onPressed: onPressed != null
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onPressed!();
                }
              : null,
          padding: padding,
        );
      },
    );
  }
}
