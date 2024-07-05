import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.darkColor = const Color(0xFFAFAFAF),
    this.lightColor = const Color(0xFF565656),
    this.fontWeight = FontWeight.w600,
    this.fontSize = 15,
  });
  final String label;
  final void Function()? onPressed;
  final Color? darkColor;
  final Color? lightColor;
  final FontWeight? fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return CupertinoButton(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: fontWeight,
              color: mode == AdaptiveThemeMode.dark ? darkColor : lightColor,
              fontSize: fontSize,
              height: 1.2,
            ),
          ),
          onPressed: onPressed != null
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onPressed!();
                }
              : null,
          disabledColor: const Color(0xFFA1A1A1),
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
        );
      },
    );
  }
}
