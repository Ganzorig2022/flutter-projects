import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/components/text/custom_text_large.dart';
import 'package:cashapp/components/text/custom_text_medium.dart';
import 'package:cashapp/constants/store_keys.dart';
import 'package:cashapp/layouts/documents/additional_information.dart';
import 'package:cashapp/layouts/documents/bank_account.dart';
import 'package:cashapp/layouts/documents/id_card/front_scan.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class LoanMain extends StatefulWidget {
  const LoanMain({super.key});

  @override
  State<LoanMain> createState() => _LoanMainState();
}

class _LoanMainState extends State<LoanMain> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
        builder: (context, mode, child) {
          return Container(
            color: mode == AdaptiveThemeMode.dark ? const Color(0xFF1F1F1F) : const Color(0xFFF6F6F6),
            child: CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  toolbarHeight: 0,
                  collapsedHeight: kBottomNavigationBarHeight,
                  expandedHeight: 310.0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Image.asset(
                            'assets/images/puzzle.png',
                            height: 160,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        CustomTextLarge(
                          'Хурдан зээл',
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            height: 1.28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                          child: SizedBox(
                            width: 295,
                            child: CustomTextMedium(
                              'Та зээл авахаасаа өмнө дараах мэдээллүүдийг бөглөх шаардлагатай!',
                              textAlign: TextAlign.center,
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: MySliverHeader(
                    minHeight: 18,
                    maxHeight: 18,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Container(
                        decoration: BoxDecoration(
                          color: mode == AdaptiveThemeMode.dark ? const Color(0xFF1F1F1F) : const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DocumentSection(
                            title: 'Зээлийн эрх тогтоох',
                            subtitle: 'E-Mongolia бүртгэлээрээ нэвтрээд зээлийн эрхээ тогтоолгох',
                            buttonText: 'Холбох',
                            mode: mode,
                            status: DocumentStatus.COMPLETED,
                            onPressed: () {},
                          ),
                          DocumentSection(
                            title: 'Хувийн мэдээлэл',
                            subtitle: 'Зээл олгохын тулд шаардлагатай мэдээллүүдийг бөглөх',
                            mode: mode,
                            expanded: true,
                            status: DocumentStatus.ACTIVE,
                            child: Column(
                              children: [
                                SubSection(
                                  mode: mode,
                                  title: 'Иргэний үнэмлэх',
                                  pendingText: 'Баталгаажуулж байна',
                                  completedText: 'Баталгаажсан',
                                  status: DocumentStatus.COMPLETED,
                                  onPressed: () {
                                    MyRouter.toWithIosBehavior(const FrontScan());
                                  },
                                ),
                                SubSection(
                                  mode: mode,
                                  title: 'Холбоо барих хүний мэдээлэл',
                                  completedText: 'Бүрдсэн',
                                  pendingText: 'Баталгаажуулж байна',
                                  status: DocumentStatus.ACTIVE,
                                  onPressed: () {
                                    MyRouter.toWithIosBehavior(const AdditionalInfo());
                                  },
                                ),
                                SubSection(
                                  mode: mode,
                                  title: 'Гэрийн хаяг',
                                  completedText: 'Бүрдсэн',
                                  status: DocumentStatus.ACTIVE,
                                  onPressed: () {
                                    MyRouter.toWithIosBehavior(const AdditionalInfo());
                                  },
                                ),
                                SubSection(
                                  mode: mode,
                                  title: 'Мэйл хаяг',
                                  completedText: 'Бүрдсэн',
                                  status: DocumentStatus.ACTIVE,
                                  onPressed: () {
                                    MyRouter.toWithIosBehavior(const AdditionalInfo());
                                  },
                                ),
                              ],
                            ),
                          ),
                          DocumentSection(
                            title: 'Данс холбох',
                            subtitle: '“Cash” ашиглан зээлээ авах дансны дугаар',
                            buttonText: 'Холбох',
                            mode: mode,
                            status: DocumentStatus.ACTIVE,
                            onPressed: () {
                              MyRouter.toWithIosBehavior(const BankAccountPage());
                            },
                          ),
                          DocumentSection(
                            title: 'Онлайн гэрээ',
                            subtitle: 'Гэрээнд гарын үсэг зурснаар таны эрх хүчинтэй болно',
                            buttonText: 'Гэрээ байгуулах',
                            mode: mode,
                            status: DocumentStatus.INACTIVE,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: const SizedBox(height: 120),
                ),
              ],
            ),
          );
        });
  }
}

class DocumentSection extends StatefulWidget {
  const DocumentSection({
    super.key,
    required this.mode,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onPressed,
    required this.status,
    this.expanded = false,
    this.child,
  });

  final AdaptiveThemeMode mode;
  final String title;
  final String subtitle;
  final Function()? onPressed;
  final String? buttonText;
  final DocumentStatus status;
  final bool expanded;
  final Widget? child;

  @override
  State<DocumentSection> createState() => _DocumentSectionState();
}

class _DocumentSectionState extends State<DocumentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: widget.mode == AdaptiveThemeMode.dark ? const Color(0xFF141414) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                Icons.check,
                size: 18,
                color: widget.status == DocumentStatus.COMPLETED ? Colors.green : null,
              )
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextLarge(
                    widget.title,
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.24,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: widget.status == DocumentStatus.ACTIVE ? 16.0 : 0),
                    child: CustomTextMedium(
                      widget.subtitle,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (widget.status == DocumentStatus.ACTIVE)
                    widget.expanded
                        ? widget.child ?? const SizedBox.shrink()
                        : SizedBox(
                            width: 100,
                            height: 32,
                            child: PrimaryButton(
                              label: widget.buttonText ?? '',
                              onPressed: widget.onPressed,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SubSection extends StatelessWidget {
  const SubSection({
    super.key,
    required this.mode,
    required this.title,
    this.pendingText,
    required this.completedText,
    this.onPressed,
    required this.status,
  });

  final AdaptiveThemeMode mode;
  final String title;
  final String? pendingText;
  final String completedText;
  final Function()? onPressed;
  final DocumentStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        color: status == DocumentStatus.ACTIVE ? const Color(0xFF141414) : Colors.transparent,
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        child: DottedBorder(
          color: mode == AdaptiveThemeMode.dark
              ? status == DocumentStatus.ACTIVE
                  ? const Color(0xFF141414)
                  : const Color(0xFF333333)
              : const Color(0xFFAFAFAF),
          radius: const Radius.circular(12),
          borderType: BorderType.RRect,
          strokeCap: StrokeCap.round,
          dashPattern: status == DocumentStatus.INACTIVE ? [6] : const <double>[3, 1],
          child: ListTile(
            dense: true,
            title: Text(title),
            enableFeedback: false,
            enabled: status != DocumentStatus.INACTIVE,
            selected: status == DocumentStatus.ACTIVE,
            selectedColor: Colors.white,
            selectedTileColor: const Color(0xFF141414),
            splashColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            subtitle: showStatusText()
                ? Text(
                    getStatusText(),
                    style: TextStyle(
                      color: getStatusTextColor(),
                    ),
                  )
                : null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            visualDensity: VisualDensity.comfortable,
            onTap: status == DocumentStatus.ACTIVE ? onPressed : null,
          ),
        ),
      ),
    );
  }

  bool showStatusText() {
    return status == DocumentStatus.PENDING || status == DocumentStatus.COMPLETED;
  }

  String getStatusText() {
    return status == DocumentStatus.PENDING ? (pendingText ?? '') : completedText;
  }

  Color getStatusTextColor() {
    return status == DocumentStatus.PENDING ? const Color(0xFFFFC043) : const Color(0xFF3AA76D);
  }
}

class MySliverHeader extends SliverPersistentHeaderDelegate {
  MySliverHeader({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(MySliverHeader oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
