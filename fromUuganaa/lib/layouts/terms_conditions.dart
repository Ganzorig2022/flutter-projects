import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../constants/values.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
        builder: (context, mode, child) {
          final bool isDark = mode == AdaptiveThemeMode.dark;
          return Material(
            color: isDark ? const Color(0xFF141414) : const Color(0xFFFFFFFF),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.clear)),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            '',
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 0.24),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(onPressed: () => null, icon: Icon(Icons.clear), color: Colors.transparent),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: const Color(0xFFAFAFAF),
                  height: 0,
                  thickness: 0.5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: ModalScrollController.of(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 34),
                            child: Image.asset(
                              'assets/splash_icon.png',
                              width: 100,
                              color: const Color(0xFFAFAFAF),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0XFFEEEEEE),
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: Text(
                                  'v2.0.1',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: const Text(
                                  'Сүүлд шинэчлэгдсэн',
                                  style: const TextStyle(fontSize: 12, color: const Color(0xFFA1A1A1), height: 1.16),
                                ),
                              ),
                              Text(
                                '2022/12/21',
                                style: const TextStyle(fontSize: 12, color: const Color(0xFFA1A1A1), height: 1.16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                            child: SizedBox(
                              width: 300,
                              child: Text(
                                'Үйлчилгээний нөхцөл',
                                style: TextStyle(
                                    fontSize: 32, color: isDark ? const Color(0xFFE2E2E2) : const Color(0xFF141414), fontWeight: FontWeight.w700, height: 1.3),
                              ),
                            ),
                          ),
                          HtmlWidget(
                            '$dummy $dummy $dummy',
                            textStyle: TextStyle(
                              color: isDark ? const Color(0xFFAFAFAF) : const Color(0xFF565656),
                              fontSize: 16,
                              height: 1.24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
