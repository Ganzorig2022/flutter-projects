import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/components/form_input.dart';
import 'package:cashapp/components/loader.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key, required this.nextRoute});
  final String nextRoute;
  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final formKey = GlobalKey<FormBuilderState>();
  bool loading = false;
  bool formValidated = false;
  final ValueNotifier<String> passwordValue = ValueNotifier<String>('');

  quetlyValidateForm() {
    formKey.currentState?.save();
    passwordValue.value = formKey.currentState?.value['password'] ?? '';
    final bool formStatus = (formKey.currentState?.isValid ?? false);
    if (formValidated != formStatus) {
      setState(() => formValidated = formStatus);
    }
  }

  void validateForm() async {
    final form = formKey.currentState;
    if (form != null && form.saveAndValidate()) {
      setState(() => loading = true);
      await Future.delayed(const Duration(seconds: 1));
      print(form.value);
      setState(() => loading = false);
      MyRouter.toNamed(widget.nextRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Шинэ нууц үг үүсгэх'),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: FormBuilder(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      initialValue: {
                        'password': '1234567',
                        'password_repeat': '1234567',
                      },
                      onChanged: quetlyValidateForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          FormInput(
                            attribute: 'password',
                            formKey: formKey,
                            label: 'Нууц үг',
                            autoFocus: false,
                            hasObscureControl: true,
                            inputType: TextInputType.visiblePassword,
                            validators: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                              FormBuilderValidators.minLength(8, errorText: 'Зөв утга оруулна уу!'),
                              FormBuilderValidators.maxLength(20, errorText: 'Зөв утга оруулна уу!'),
                            ]),
                            autofillHints: [
                              AutofillHints.password,
                            ],
                          ),
                          FormInput(
                            attribute: 'password_repeat',
                            formKey: formKey,
                            label: 'Нууц үг баталгаажуулах',
                            hasObscureControl: true,
                            inputType: TextInputType.visiblePassword,
                            validators: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                              FormBuilderValidators.minLength(8, errorText: 'Зөв утга оруулна уу!'),
                              FormBuilderValidators.maxLength(20, errorText: 'Зөв утга оруулна уу!'),
                            ]),
                            autofillHints: [
                              AutofillHints.password,
                            ],
                          ),
                          const SizedBox(height: 16),
                          ValueListenableBuilder<String>(
                            valueListenable: passwordValue,
                            builder: (context, value, child) {
                              return PasswordValidationMonitor(valueNotifier: passwordValue);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
                  child: PrimaryButton(
                    label: 'Үргэлжлүүлэх',
                    onPressed: formValidated ? validateForm : null,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (loading) const Loader(),
      ],
    );
  }
}

class PasswordValidationMonitor extends StatelessWidget {
  const PasswordValidationMonitor({super.key, required this.valueNotifier});
  final ValueNotifier<String> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return Column(
          children: [
            ValidationStatusWidget(label: '8-20 оронтой байх', isValid: value.isInRange()),
            ValidationStatusWidget(label: '1 том үсэг агуулсан байх', isValid: value.isContainsUpperCase()),
            ValidationStatusWidget(label: '1 тоо агуулсан байх', isValid: value.isContainsDigit()),
            ValidationStatusWidget(label: 'Зай авахгүй байх', isValid: value.isContainsWhiteSpace()),
          ],
        );
      },
    );
  }
}

class ValidationStatusWidget extends StatelessWidget {
  const ValidationStatusWidget({super.key, required this.label, required this.isValid});
  final String label;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ValueListenableBuilder(
        valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
        builder: (context, mode, child) {
          final bool isDark = mode == AdaptiveThemeMode.dark;
          return Row(
            children: [
              isValid
                  ? const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: const Color(0xFF3AA76D),
                    )
                  : Icon(
                      Icons.clear,
                      size: 16,
                      color: isDark ? const Color(0xFFAFAFAF) : const Color(0xFF565656),
                    ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.2,
                  color: isValid
                      ? const Color(0xFF3AA76D)
                      : isDark
                          ? const Color(0xFFAFAFAF)
                          : const Color(0xFF565656),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

extension PasswordValidator on String {
  bool isContainsUpperCase() {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(this);
  }

  bool isContainsDigit() {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(this);
  }

  bool isInRange() {
    return RegExp(r'^(.{8,16})$').hasMatch(this);
  }

  bool isContainsWhiteSpace() {
    return this.isNotEmpty && !this.contains(' ');
  }
}
