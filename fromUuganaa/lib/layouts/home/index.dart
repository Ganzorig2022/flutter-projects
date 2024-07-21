import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/fade_indexed_stack.dart';
import 'package:cashapp/layouts/home/loan_main.dart';
import 'package:cashapp/layouts/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  RxInt index = 0.obs;

  void changeIndex(int i) {
    if (index.value != i) {
      HapticFeedback.lightImpact();
      index.value = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: PreferredSize(
            child: Obx(
              () => index == 2
                  ? AppBar(
                      leadingWidth: 120,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Center(
                          child: Text(
                            'Профайл',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.16,
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 16),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {},
                            child: Image.asset(
                              mode == AdaptiveThemeMode.dark ? 'assets/icons/notification_light.png' : 'assets/icons/notification_dark.png',
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    )
                  : AppBar(
                      leadingWidth: 100,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Image.asset(
                          'assets/splash_icon.png',
                          width: 72,
                          color: mode == AdaptiveThemeMode.dark ? const Color(0xFFE2E2E2) : const Color(0xFF141414),
                        ),
                      ),
                      actions: [
                        InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {},
                          child: Image.asset(
                            mode == AdaptiveThemeMode.dark ? 'assets/icons/loan_history_light.png' : 'assets/icons/loan_history_dark.png',
                            width: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 16),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {},
                            child: Image.asset(
                              mode == AdaptiveThemeMode.dark ? 'assets/icons/notification_light.png' : 'assets/icons/notification_dark.png',
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            width: 240,
            height: 64,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(64),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 8,
                  offset: Offset(0, 0), // Shadow position
                  spreadRadius: -7,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => changeIndex(0),
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: NavItem(
                          index: 0,
                          indexNotifier: index,
                          mode: mode,
                          activeIcon: 'assets/navbar/loan_active.png',
                          inActiveIcon: 'assets/navbar/loan.png',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => changeIndex(1),
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: NavItem(
                          index: 1,
                          indexNotifier: index,
                          mode: mode,
                          activeIcon: 'assets/navbar/market_place_active.png',
                          inActiveIcon: 'assets/navbar/market_place.png',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => changeIndex(2),
                      child: Container(
                          height: 64,
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          child: NavItem(
                            index: 2,
                            indexNotifier: index,
                            mode: mode,
                            activeIcon: 'assets/navbar/profile_active.png',
                            inActiveIcon: 'assets/navbar/profile.png',
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: Obx(
              () => FadeIndexedStack(
                sizing: StackFit.expand,
                index: index.value,
                children: const [
                  const LoanMain(),
                  const LoanMainPage(),
                  const ProfilePage(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.index,
    required this.indexNotifier,
    required this.mode,
    required this.activeIcon,
    required this.inActiveIcon,
  });

  final RxInt indexNotifier;
  final AdaptiveThemeMode mode;
  final String activeIcon;
  final String inActiveIcon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => indexNotifier.value == index
          ? Image.asset(
              activeIcon,
              height: 20,
              color: mode == AdaptiveThemeMode.dark ? const Color(0xFFE2E2E2) : const Color(0xFF141414),
            )
          : Image.asset(
              inActiveIcon,
              height: 20,
              color: mode == AdaptiveThemeMode.dark ? const Color(0xFFA1A1A1) : const Color(0xFFA1A1A1),
            ),
    );
  }
}

class LoanMainPage extends StatefulWidget {
  const LoanMainPage({super.key});

  @override
  State<LoanMainPage> createState() => _LoanMainPageState();
}

class _LoanMainPageState extends State<LoanMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        );
  }
}
