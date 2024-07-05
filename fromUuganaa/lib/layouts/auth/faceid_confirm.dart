import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/components/button/secondary_button.dart';
import 'package:cashapp/components/text/custom_text_large.dart';
import 'package:cashapp/components/text/custom_text_medium.dart';
import 'package:cashapp/layouts/home/index.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';

class FaceIDConfirm extends StatefulWidget {
  const FaceIDConfirm({super.key});

  @override
  State<FaceIDConfirm> createState() => _FaceIDConfirmState();
}

class _FaceIDConfirmState extends State<FaceIDConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face ID'),
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
            builder: (context, mode, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 120 - kBottomNavigationBarHeight),
                    child: Image.asset('assets/images/face.png', width: 200),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 8),
                    child: SizedBox(
                      width: 260,
                      child: CustomTextLarge(
                        'Царайгаа уншуулна уу?',
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 21,
                          height: 1.28,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: CustomTextMedium(
                      'Царайгаар нэвтэрснээр “Cash” апп-руу хурдан нэвтрэх боломжтой болно.',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),
                  Padding(
                    padding: const EdgeInsets.only(top: 42.0, bottom: 16, left: 74, right: 74),
                    child: PrimaryButton(
                      label: 'Идэвхжүүлэх',
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 46, left: 74, right: 74),
                    child: SecondaryButton(
                      label: 'Дараа болох',
                      onPressed: () {
                        MyRouter.offAllWithIosBehavior(HomeScreen());
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
