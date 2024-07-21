import 'package:cashapp/components/text/custom_text_large.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';

class NumPad extends StatefulWidget {
  const NumPad({
    super.key,
    required this.title,
    required this.pinLength,
    required this.onCompleted,
    this.bioMetricAuth = false,
  });
  final String title;
  final int pinLength;
  final Future<bool> Function(String value) onCompleted;
  final bool bioMetricAuth;

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  String pinCode = '';
  final shakeKey = GlobalKey<ShakeWidgetState>();

  void reset() async {
    Future.delayed(
      const Duration(milliseconds: 200),
      () => HapticFeedback.heavyImpact(),
    );
    shakeKey.currentState?.shake();
    setState(() => pinCode = '');
  }

  concatPin(String value) async {
    if (pinCode.length < widget.pinLength) {
      setState(() => pinCode += value);
      if (pinCode.length == widget.pinLength) {
        final bool isOk = await widget.onCompleted(pinCode);
        if (!isOk) {
          reset();
        }
      }
    }
  }

  removeLastCode() {
    if (pinCode.length > 0) {
      pinCode = pinCode.substring(0, pinCode.length - 1);
      setState(() {});
    }
  }

  //biometric check
  authenticate() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 24),
          child: CustomTextLarge(
            widget.title,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
              fontSize: 16,
              height: 1.24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ShakeMe(
            key: shakeKey,
            shakeCount: 3,
            shakeOffset: 10,
            shakeDuration: const Duration(milliseconds: 400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.pinLength, (index) => ++index)
                  .map(
                    (e) => PinField(
                      active: e <= pinCode.length,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: GridView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 24,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                  case 1:
                  case 2:
                  case 3:
                  case 4:
                  case 5:
                  case 6:
                  case 7:
                  case 8:
                    return KeyPad(
                      value: '${++index}',
                      onTap: concatPin,
                    );
                  case 9:
                    return widget.bioMetricAuth ? BioMetric(onTap: authenticate) : const SizedBox.shrink();
                  case 10:
                    return KeyPad(
                      value: '0',
                      onTap: concatPin,
                    );
                  case 11:
                    return Clear(onTap: removeLastCode);
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class KeyPad extends StatelessWidget {
  const KeyPad({super.key, required this.value, required this.onTap});
  final String value;
  final Function(String value) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: CommonUtils.isDarkMode(context) ? const Color(0xFF333333) : const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap(value);
        },
        child: Center(
          child: Text(
            value,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.28,
                color: CommonUtils.isDarkMode(context) ? const Color(0xFFE2E2E2) : const Color(0xFF141414)),
          ),
        ),
      ),
    );
  }
}

class Clear extends StatelessWidget {
  const Clear({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: CommonUtils.isDarkMode(context) ? const Color(0xFF333333) : const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Center(
          child: ImageIcon(AssetImage('assets/icons/num_clear_light.png')),
        ),
      ),
    );
  }
}

class PinField extends StatelessWidget {
  const PinField({super.key, this.active = false});
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF4CA92E) : const Color(0xFFD9D9D9),
        shape: BoxShape.circle,
      ),
    );
  }
}

class BioMetric extends StatelessWidget {
  const BioMetric({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: CommonUtils.isDarkMode(context) ? const Color(0xFF333333) : const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Center(
          child: ImageIcon(AssetImage('assets/icons/faceid.png')),
        ),
      ),
    );
  }
}
