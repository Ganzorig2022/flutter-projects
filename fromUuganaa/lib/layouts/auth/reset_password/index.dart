import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/components/form_input.dart';
import 'package:cashapp/components/loader.dart';
import 'package:cashapp/layouts/auth/phone_verification.dart';
import 'package:cashapp/layouts/auth/reset_password/success.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../create_password.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool loading = false;
  bool formValidated = false;

  quetlyValidateForm() {
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
      final result = await showCupertinoModalBottomSheet<bool?>(
        expand: true,
        context: context,
        isDismissible: false,
        enableDrag: false,
        topRadius: Radius.circular(12),
        builder: (context) => PhoneVerificationPage(phone: form.value['phone']),
      );
      if (result ?? false) {
        MyRouter.toWithIosBehavior(CreatePassword(nextRoute: ResetSuccessPage.route));
      }
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
            title: const Text('Нууц үг сэргээх'),
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
                      onChanged: quetlyValidateForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          FormInput(
                            attribute: 'phone',
                            formKey: formKey,
                            label: 'Утасны дугаар',
                            autoFocus: false,
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
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
                  child: PrimaryButton(
                    label: 'Баталгаажуулах код илгээх',
                    onPressed: formValidated ? validateForm : null,
                  ),
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
