import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/custom_text_button.dart';
import 'package:cashapp/components/button/secondary_button.dart';
import 'package:cashapp/components/custom_label.dart';
import 'package:cashapp/components/form_input.dart';
import 'package:cashapp/components/loader.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/layouts/auth/faceid_confirm.dart';
import 'package:cashapp/layouts/auth/register/index.dart';
import 'package:cashapp/layouts/auth/reset_password/index.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
  static String route = '/login';
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormBuilderState>();
  bool loading = false;
  bool formValidated = false;

  void validateForm() async {
    final form = formKey.currentState;
    if (form != null && form.saveAndValidate()) {
      setState(() => loading = true);
      await Future.delayed(const Duration(seconds: 1));
      print(form.value);
      setState(() => loading = false);
      MyRouter.toWithIosBehavior(const FaceIDConfirm());
    }
  }

  quetlyValidateForm() {
    final bool formStatus = (formKey.currentState?.isValid ?? false);
    if (formValidated != formStatus) {
      setState(() => formValidated = formStatus);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), quetlyValidateForm);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Нэвтрэх'),
            actions: [
              ValueListenableBuilder(
                valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
                builder: (_, mode, child) {
                  return IconButton(
                    icon: mode == AdaptiveThemeMode.dark ? const Icon(CupertinoIcons.brightness_solid) : const Icon(CupertinoIcons.moon_fill),
                    onPressed: () {
                      if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                        AdaptiveTheme.of(context).setLight();
                      } else {
                        AdaptiveTheme.of(context).setDark();
                      }
                    },
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: FormBuilder(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        onChanged: quetlyValidateForm,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 24),
                            FormInput(
                              attribute: 'phone',
                              formKey: formKey,
                              autoFocus: false,
                              label: 'Утасны дугаар',
                              inputType: TextInputType.number,
                              validators: FormBuilderValidators.compose([
                                FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                                FormBuilderValidators.numeric(errorText: 'Зөв утга оруулна уу!'),
                                FormBuilderValidators.equalLength(8, errorText: 'Зөв утга оруулна уу!'),
                              ]),
                              autofillHints: [
                                AutofillHints.telephoneNumberDevice,
                              ],
                            ),
                            FormInput(
                              attribute: 'password',
                              formKey: formKey,
                              label: 'Нууц үг',
                              inputType: TextInputType.visiblePassword,
                              hasObscureControl: true,
                              onComplete: formValidated ? validateForm : null,
                              validators: FormBuilderValidators.compose([
                                FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                              ]),
                              autofillHints: [
                                AutofillHints.password,
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                CustomTextButton(
                                  label: 'Нууц үгээ мартсан?',
                                  fontWeight: FontWeight.w500,
                                  lightColor: const Color(0xFF333333),
                                  darkColor: const Color(0xFFE2E2E2),
                                  onPressed: () {
                                    MyRouter.toWithIosBehavior(const ResetPasswordPage());
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: PrimaryButton(
                                label: 'Нэвтрэх',
                                onPressed: formValidated ? validateForm : null,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24.0),
                                child: CustomLabel(label: 'Эсвэл'),
                              ),
                            ),
                            SecondaryButton(
                              label: 'Face ID- аар нэвтрэх',
                              icon: Image.asset('assets/icons/faceid.png', height: 15, width: 15),
                              onPressed: () => null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    CustomLabel(
                      label: 'Та бүртгэлгүй юу?',
                      fontSize: 14,
                      height: 1.24,
                    ),
                    CustomTextButton(
                      label: 'Бүртгүүлэх',
                      lightColor: const Color(0xFF000000),
                      darkColor: const Color(0xFFE2E2E2),
                      onPressed: () {
                        MyRouter.replaceWithFadeIn(const RegisterPage());
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        if (loading) const Loader(),
      ],
    );
  }
}
