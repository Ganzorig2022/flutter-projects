import 'dart:convert';
import 'dart:ui';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const printDecoder = JsonEncoder.withIndent('  ');
const localeMn = Locale('mn', 'MN');
const localeEn = Locale('en', 'US');

class MyRouter {
  static Future toWithIosBehavior(Widget page) async {
    await Navigator.of(Get.context!).push(MaterialWithModalsPageRoute(
      builder: (context) => page,
    ));
  }

  static Future offWithIosBehavior(Widget page) async {
    await Navigator.of(Get.context!).pushReplacement(MaterialWithModalsPageRoute(
      builder: (context) => page,
    ));
  }

  static Future offAllWithIosBehavior(Widget page) async {
    await Navigator.of(Get.context!).pushAndRemoveUntil(
      MaterialWithModalsPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );
  }

  // overring get default transition

  static void back({dynamic result}) async {
    Get.back(result: result);
  }

  static Future toWithFadeIn(Widget page) async {
    await Get.to(page, transition: Transition.fadeIn);
  }

  static Future replaceWithFadeIn(Widget page) async {
    await Get.off(page, transition: Transition.fadeIn);
  }

  static Future off(Widget page) async {
    await Get.off(page);
  }

  static Future offAll(Widget page) async {
    await Get.offAll(page);
  }

  static Future toNamed(String page) async {
    await Get.toNamed(page);
  }

  static Future offNamed(String page) async {
    await Get.offNamed(page);
  }

  static Future offAllNamed(String page) async {
    await Get.offAllNamed(page);
  }

  static void offNamedUntil(String route) async {
    Get.offNamedUntil(route, (route) => route.settings.name == route);
  }
}

final GetStorage getStorage = GetStorage();

class CommonUtils {
  static bool isDarkMode(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
  }

  static Future<void> saveValueToStorage(String key, dynamic value) async => getStorage.write(key, value);
  static T? getValueFromStorage<T>(String key) => GetStorage().read(key);
  static Future<void> removeValueFromStorage(String key) async => getStorage.remove(key);
  static Future<void> clearStorage() async => getStorage.erase();
  static bool hasData(String key) => getStorage.hasData(key);

  static void showErrorDialog({required String title, required String message}) async {
    await Get.defaultDialog(
      radius: 16,
      contentPadding: EdgeInsets.zero,
      barrierDismissible: true,
      titleStyle: const TextStyle(color: Colors.redAccent),
      title: title,
      titlePadding: title.isNotEmpty ? const EdgeInsets.only(top: 12) : EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (title.isNotEmpty) const Divider(height: 1),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 48,
              ),
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      cancel: MaterialButton(
        minWidth: double.infinity,
        onPressed: () => Get.back(),
        color: Colors.redAccent,
        textColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        elevation: 0,
        enableFeedback: false,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        child: const Text('ХААХ'),
      ),
    );
  }

  static void showSuccessDialog({required String message}) async {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/dialog_header.png',
                fit: BoxFit.fitHeight,
              ),
              Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                  margin: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 0.5,
                        spreadRadius: -1,
                        offset: Offset(0, -2), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CupertinoButton(
                        child: const Text('Хаах'),
                        onPressed: () {
                          if (Get.isDialogOpen ?? false) {
                            Get.back();
                          }
                        },
                        padding: const EdgeInsets.only(top: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black26,
    );
  }

  static void showSuccessFlash({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
    );
  }

  static void showErrorFlash({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
    );
  }

  static void showSnackBar({String? title, required String message, Color color = const Color(0xFF303030)}) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 1, milliseconds: 500),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color,
    ));
  }

  static print(Object? object) {
    debugPrint(printDecoder.convert(object));
  }

  static logError(String code, String? message) {
    // ignore: avoid_print
    print('Error: $code${message == null ? '' : '\nError Message: $message'}');
  }
}
