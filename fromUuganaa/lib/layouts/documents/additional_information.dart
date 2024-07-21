import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/components/form_dropdown.dart';
import 'package:cashapp/components/form_input.dart';
import 'package:cashapp/model/reference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({super.key});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  final formKey = GlobalKey<FormBuilderState>();
  final dummyList = ['аав', 'ээж', 'ах', 'дүү'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: false,
      appBar: AppBar(title: const Text('Нэмэлт мэдээлэл'), centerTitle: true),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF4CA92E),
                  padding: const EdgeInsets.only(left: 26, right: 24, top: 16, bottom: 16),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.white),
                      const SizedBox(width: 26),
                      Expanded(
                        child: Text(
                          'Яаралтай үед холбоо барих хоёр хүний холбогдох мэдээллийг  оруулна уу!',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.4,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderTitle(text: '1. Холбоо барих хүний мэдээлэл'),
                        FormInput(
                          attribute: 'last_name',
                          formKey: formKey,
                          label: 'Овог',
                          autoFocus: false,
                          inputType: TextInputType.text,
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                          ]),
                        ),
                        FormInput(
                          attribute: 'first_name',
                          formKey: formKey,
                          label: 'Нэр',
                          autoFocus: false,
                          inputType: TextInputType.text,
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                          ]),
                        ),
                        FormDropDown(
                          attribute: 'whos',
                          formKey: formKey,
                          label: 'Таны хэн болох?',
                          items: dummyList.map<Reference>((e) => Reference(id: e, name: e)).toList(),
                        ),
                        FormInput(
                          attribute: 'phone',
                          formKey: formKey,
                          autoFocus: false,
                          label: 'Утасны дугаар',
                          ensureVisible: true,
                          inputType: TextInputType.number,
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                            FormBuilderValidators.numeric(errorText: 'Зөв утга оруулна уу!'),
                            FormBuilderValidators.equalLength(8, errorText: 'Зөв утга оруулна уу!'),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: const Divider(height: 0),
                ),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderTitle(text: '2. Холбоо барих хүний мэдээлэл'),
                        FormInput(
                          attribute: 'last_name',
                          formKey: formKey,
                          label: 'Овог',
                          autoFocus: false,
                          inputType: TextInputType.text,
                          ensureVisible: true,
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                          ]),
                        ),
                        FormInput(
                          attribute: 'first_name',
                          formKey: formKey,
                          label: 'Нэр',
                          autoFocus: false,
                          inputType: TextInputType.text,
                          ensureVisible: true,
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                          ]),
                        ),
                        FormDropDown(
                          attribute: 'whos',
                          formKey: formKey,
                          label: 'Таны хэн болох?',
                          items: dummyList.map<Reference>((e) => Reference(id: e, name: e)).toList(),
                        ),
                        FormInput(
                          attribute: 'phone',
                          formKey: formKey,
                          autoFocus: false,
                          label: 'Утасны дугаар',
                          inputType: TextInputType.number,
                          ensureVisible: true,
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
                const SizedBox(height: 120),
                // Padding(
                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                // ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
              decoration: BoxDecoration(
                color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark ? const Color(0xFF141414) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, -4), // Shadow position
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: SafeArea(
                child: PrimaryButton(
                  label: 'Хадгалах',
                  onPressed: () => null,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.24,
        ),
      ),
    );
  }
}
