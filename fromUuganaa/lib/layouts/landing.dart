import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/white_green_button.dart';
import 'package:cashapp/layouts/auth/login.dart';
import 'package:cashapp/layouts/auth/register/index.dart';
import 'package:cashapp/layouts/terms_conditions.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  static String route = '/landingpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 60, bottom: 20),
            child: ValueListenableBuilder(
                valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
                builder: (context, mode, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 26.0),
                        child: SizedBox(
                          width: 110,
                          height: 36,
                          child: FittedBox(
                            child: Image.asset('assets/splash_icon.png'),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 90),
                        child: SizedBox(
                          width: 295,
                          height: 64,
                          child: Text(
                            '“Cash” апп-д тавтай морил',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white, height: 1.32),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: WhiteGreenButton(
                            label: 'Бүртгүүлэх',
                            onPressed: () {
                              MyRouter.toWithIosBehavior(RegisterPage());
                            },
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  border: Border.all(color: Colors.white, width: 1),
                                ),
                                child: CupertinoButton(
                                  child: Text(
                                    'Нэвтрэх',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 15,
                                      height: 1.2,
                                    ),
                                  ),
                                  onPressed: () {
                                    MyRouter.toNamed(Login.route);
                                  },
                                  borderRadius: BorderRadius.circular(36),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 310,
                        child: RichText(
                          text: TextSpan(
                            text: 'Та нэвтрэх болон бүртгүүлэх товчыг дарснаар манай',
                            children: [
                              TextSpan(
                                text: ' Үйлчилгээний нөхцөлийг ',
                                style: const TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showCupertinoModalBottomSheet<String?>(
                                      expand: true,
                                      context: Get.context!,
                                      isDismissible: false,
                                      enableDrag: true,
                                      topRadius: Radius.circular(12),
                                      builder: (context) => TermsAndConditions(),
                                    );
                                  },
                              ),
                              TextSpan(text: 'зөвшөөрсөнд тооцно.'),
                            ],
                            style: const TextStyle(
                              color: const Color(0xFFC1C1C1),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                              height: 1.6,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
