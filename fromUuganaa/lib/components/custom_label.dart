import 'package:flutter/cupertino.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    super.key,
    required this.label,
    this.fontWeight,
    this.fontSize = 12,
    this.height = 1.16,
  });
  final String label;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: height,
        color: const Color(0xFF757575),
      ),
    );
  }
}
