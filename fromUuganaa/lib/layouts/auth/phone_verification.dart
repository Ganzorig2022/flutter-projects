import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/custom_text_button.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/components/loader.dart';
import 'package:cashapp/components/text/custom_text_medium.dart';
import 'package:cashapp/constants/values.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final TextEditingController textEditingController = TextEditingController();
  bool loading = false;
  bool formValidated = false;

  @override
  void initState() {
    super.initState();
  }

  void resend() async {
    textEditingController.clear();
  }

  void confirm(String code) async {
    setState(() {
      formValidated = true;
      loading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() => loading = false);
    MyRouter.back(result: true);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(title: Text('Баталгаажуулах')),
          body: SafeArea(
            top: false,
            child: ValueListenableBuilder(
              valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
              builder: (context, mode, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Divider(color: const Color(0xFFEEEEEE), thickness: 1),
                    Padding(
                      padding: EdgeInsets.only(top: 24.0, left: 36, right: 36),
                      child: CustomTextMedium(
                        'Таны ${widget.phone} дугаарт илгээсэн 6 оронтой баталгаажуулах кодыг оруулна уу.',
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: mode == AdaptiveThemeMode.dark ? const Color(0xFFAFAFAF) : const Color(0xFF565656),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40, top: 26, bottom: 12),
                      child: SizedBox(
                        width: 270,
                        child: InputDecorator(
                          expands: false,
                          isFocused: true,
                          decoration: InputDecoration(
                            border: outLinedBorder(mode),
                            enabledBorder: outLinedBorder(mode),
                            focusedBorder: outLinedFocusedBorder(mode),
                            disabledBorder: outLinedBorder(mode),
                            errorBorder: outLinedErrorBorder,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            isDense: true,
                          ),
                          child: PinCodeTextField(
                            length: 6,
                            controller: textEditingController,
                            appContext: context,
                            obscureText: false,
                            errorTextSpace: 0,
                            animationType: AnimationType.scale,
                            autoDismissKeyboard: true,
                            keyboardType: TextInputType.number,
                            enablePinAutofill: true,
                            autoUnfocus: true,
                            keyboardAppearance: mode == AdaptiveThemeMode.dark ? Brightness.dark : Brightness.light,
                            scrollPadding: EdgeInsets.zero,
                            autoFocus: true,
                            onAutoFillDisposeAction: AutofillContextAction.commit,
                            showCursor: false,
                            autoDisposeControllers: false,
                            textStyle: TextStyle(
                              color: mode == AdaptiveThemeMode.dark ? const Color(0xFFE2E2E2) : const Color(0xFF141414),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              borderRadius: BorderRadius.circular(16),
                              borderWidth: 0,
                              selectedFillColor: Colors.transparent,
                              fieldHeight: 24,
                              activeFillColor: Colors.transparent,
                              activeColor: Colors.transparent,
                              inactiveFillColor: Colors.transparent,
                              inactiveColor: Colors.transparent,
                              selectedColor: Colors.transparent,
                            ),
                            hintCharacter: '-',
                            hintStyle: const TextStyle(color: const Color(0xFFAFAFAF), fontSize: 15),
                            hapticFeedbackTypes: HapticFeedbackTypes.selection,
                            animationDuration: const Duration(milliseconds: 150),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: false,
                            onCompleted: (code) => confirm(code),
                            onChanged: (v) => null,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        CustomTextMedium(
                          'Та код аваагүй юу?',
                          textStyle: const TextStyle(fontSize: 14, height: 1.24),
                        ),
                        CustomTextButton(
                          label: 'Дахин илгээх',
                          lightColor: const Color(0xFF000000),
                          darkColor: const Color(0xFFE2E2E2),
                          onPressed: resend,
                        ),
                        const Spacer(),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: PrimaryButton(
                        label: 'Үргэлжлүүлэх',
                        onPressed: formValidated ? () => confirm(textEditingController.text) : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ),
        if (loading) const Loader(),
      ],
    );
  }
}
