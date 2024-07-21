import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/custom_text_button.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/layouts/landing.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import '../utils/common_util.dart';

class WalkThrough extends StatelessWidget {
  WalkThrough({super.key});
  final PageController controller = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  static String route = '/walkthrough';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Center(
                child: PageView(
                  controller: controller,
                  onPageChanged: (int index) {
                    _currentPageNotifier.value = index;
                  },
                  children: [
                    const PageItem(
                      asset: 'assets/images/loan.png',
                      title: 'Ямар ч барьцаа шаардлагагүй онлайн зээл',
                      desc: 'Салбар дээр очиж цаг алдахгүй хэдхэн товч дараад зээлээ онлайнаар авах боломж',
                    ),
                    const PageItem(
                      asset: 'assets/images/payback.png',
                      title: 'Бүтээгдэхүүнээ аваад дараа төл',
                      desc: 'Та өөрт таалагдсан бүтээгдэхүүнээ сонгоод ямар ч шимтгэлгүй хувааж төлөх боломж',
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
              builder: (context, mode, child) {
                return CirclePageIndicator(
                  itemCount: 2,
                  currentPageNotifier: _currentPageNotifier,
                  dotColor: const Color(0xFFA1A1A1),
                  selectedDotColor: mode == AdaptiveThemeMode.dark ? const Color(0xFFE2E2E2) : const Color(0xFF141414),
                );
              },
            ),
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PrimaryButton(
                label: 'Дараах',
                onPressed: () {
                  if (controller.page == 1.toDouble()) {
                    MyRouter.offWithIosBehavior(LandingPage());
                  } else {
                    controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 36),
              child: CustomTextButton(
                label: 'Алгасах',
                onPressed: () {
                  MyRouter.offWithIosBehavior(LandingPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  const PageItem({super.key, required this.asset, this.title, this.desc});
  final String asset;
  final String? title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(asset, width: size.width * 0.7),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 38, right: 38, bottom: 12),
          child: Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 36, right: 36),
          child: Text(
            desc ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
