import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/constants/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, child) {
        return Container(
          color: mode == AdaptiveThemeMode.dark ? const Color(0xFF1F1F1F) : const Color(0xFFF6F6F6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(text: 'Үндсэн цэс', mode: mode),
                  CustomContainer(
                    mode: mode,
                    child: Column(
                      children: [
                        ListItem(
                          mode: mode,
                          label: 'Хувийн мэдээлэл',
                          iconPath: 'assets/icons/profile/user.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Дансны мэдээлэл',
                          iconPath: 'assets/icons/profile/bank_account.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Зээлийн тодорхойлолт татах',
                          iconPath: 'assets/icons/profile/download.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SectionTitle(text: 'Тохиргоо', mode: mode),
                  CustomContainer(
                    mode: mode,
                    child: Column(
                      children: [
                        ListItem(
                          mode: mode,
                          label: 'Утасны дугаар солих',
                          iconPath: 'assets/icons/profile/phone.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Нэвтрэх нууц үг солих',
                          iconPath: 'assets/icons/profile/key.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Гүйлгээний пин код солих',
                          iconPath: 'assets/icons/profile/lock.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Гүйлгээний пин код сэргээх',
                          iconPath: 'assets/icons/profile/lock.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Шөнийн горим',
                          iconPath: 'assets/icons/profile/mode.png',
                          showThemeSwitcher: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SectionTitle(text: 'Туслах', mode: mode),
                  CustomContainer(
                    mode: mode,
                    child: Column(
                      children: [
                        ListItem(
                          mode: mode,
                          label: 'Үйлчилгээний нөхцөл',
                          iconPath: 'assets/icons/profile/terms.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Түгээмэл асуултууд',
                          iconPath: 'assets/icons/profile/faq.png',
                          onTap: () {},
                        ),
                        ListItem(
                          mode: mode,
                          label: 'Холбоо барих',
                          iconPath: 'assets/icons/profile/phone.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 120),
                    child: CustomContainer(
                      mode: mode,
                      child: ListItem(
                        mode: mode,
                        label: 'Гарах',
                        iconPath: 'assets/icons/profile/log_out.png',
                        foregroundColor: const Color(0xFFD44333),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text, required this.mode});
  final AdaptiveThemeMode mode;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
            color: mode == AdaptiveThemeMode.dark ? const Color(0xFFAFAFAF) : const Color(0xFF565656), fontSize: 14, height: 1.18, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.mode, required this.child});
  final AdaptiveThemeMode mode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mode == AdaptiveThemeMode.dark ? const Color(0xFF141414) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.mode,
    required this.label,
    required this.iconPath,
    this.showThemeSwitcher = false,
    this.foregroundColor,
    this.onTap,
  });

  final AdaptiveThemeMode mode;
  final String label;
  final String iconPath;
  final bool showThemeSwitcher;
  final Color? foregroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 25,
      dense: true,
      isThreeLine: false,
      leading: Image.asset(
        iconPath,
        color: foregroundColor != null ? foregroundColor : profileTerxtColor(mode),
        width: 16,
        height: 16,
      ),
      // leading: ImageIcon(
      //   AssetImage(iconPath),
      //   color: profileTerxtColor(mode),
      //   size: 18,
      // ),
      title: Text(
        label,
        style: TextStyle(color: foregroundColor != null ? foregroundColor : profileTerxtColor(mode)),
      ),
      trailing: showThemeSwitcher ? const ThemeSwitcher() : null,
      onTap: onTap,
    );
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 28,
      child: FittedBox(
        child: ValueListenableBuilder(
          valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
          builder: (context, mode, child) {
            return CupertinoSwitch(
              value: mode == AdaptiveThemeMode.dark,
              trackColor: mode == AdaptiveThemeMode.dark ? const Color(0xFF333333) : const Color(0xFFEEEEEE),
              thumbColor: mode == AdaptiveThemeMode.dark ? const Color(0xFFEEEEEE) : const Color(0xFFA1A1A1),
              activeColor: const Color(0xFF4CA92E),
              onChanged: (v) {
                if (v) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
