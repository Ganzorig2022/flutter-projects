import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/components/form_dropdown.dart';
import 'package:cashapp/components/form_input.dart';
import 'package:cashapp/model/reference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final dummyList = ['Хаан банк', 'Төрийн банк', 'Худалдаа хөгжлийн банк', 'Хас банк', 'Голомт банк'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: false,
      appBar: AppBar(title: const Text('Данс холбох'), centerTitle: true),
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
                      Icon(Icons.account_balance_wallet, color: Colors.white),
                      const SizedBox(width: 26),
                      Expanded(
                        child: Text(
                          'Зөвхөн өөрийн нэр дээрх дансаа л оруулах боломжтойг анхаарна уу!',
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormDropDown(
                        attribute: 'bank',
                        formKey: formKey,
                        label: 'Банк',
                        items: dummyList
                            .map<Reference>((e) => Reference(
                                  id: e,
                                  name: e,
                                  img: (dummyList.indexOf(e) % 2 == 0) ? 'https://i.ibb.co/G0jkSq8/Bank.png' : 'https://i.ibb.co/M7zzn9d/XAC.png',
                                ))
                            .toList(),
                      ),
                      FormInput(
                        attribute: 'account_number',
                        formKey: formKey,
                        autoFocus: false,
                        label: 'Дансны дугаар',
                        inputType: TextInputType.number,
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                          FormBuilderValidators.numeric(errorText: 'Зөв утга оруулна уу!'),
                          // FormBuilderValidators.equalLength(8, errorText: 'Зөв утга оруулна уу!'),
                        ]),
                      ),
                      FormInput(
                        attribute: 'account_name',
                        formKey: formKey,
                        label: 'Данс эзэмшигчийн нэр',
                        autoFocus: false,
                        inputType: TextInputType.text,
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
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
                  label: 'Холбох',
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
