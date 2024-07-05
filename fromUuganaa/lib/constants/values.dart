import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String baseUrl = 'https://api-app.khuduugaray.com';
const String registerNumberPatttern = r'(^\d{8}$)';
const Color primaryColor = Color(0xff7D73C3);
const Color primaryColor2 = Color.fromARGB(255, 125, 19, 254);
const Color borderColor = Color(0xffE4DFDF);
final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
final DateFormat dateFormat2 = DateFormat('yyyy.MM.dd');
final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm');

OutlineInputBorder outLinedErrorBorder = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(
    color: Colors.red.withOpacity(0.5),
    width: 2,
  ),
);

OutlineInputBorder outLinedBorder(AdaptiveThemeMode mode) => OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: mode == AdaptiveThemeMode.dark
            ? Color(0xFF333333)
            : Color(0xFFEEEEEE),
        width: 2,
      ),
    );

OutlineInputBorder outLinedFocusedBorder(AdaptiveThemeMode mode) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: mode == AdaptiveThemeMode.dark
            ? Color(0xFFAFAFAF)
            : Color(0xFF141414).withOpacity(0.8),
        width: 2,
      ),
    );

labelStyle(AdaptiveThemeMode mode) => TextStyle(
      color: mode == AdaptiveThemeMode.dark
          ? Color(0xFFAFAFAF)
          : Color(0xFF565656),
      fontWeight: FontWeight.w400,
    );

profileTerxtColor(AdaptiveThemeMode mode) =>
    mode == AdaptiveThemeMode.dark ? Color(0xFFE2E2E2) : Color(0xFF141414);

const alphabets = [
  'A',
  'Б',
  'В',
  'Г',
  'Д',
  'Е',
  'Ё',
  'Ж',
  'З',
  'И',
  'Й',
  'К',
  'Л',
  'М',
  'Н',
  'О',
  'Ө',
  'П',
  'Р',
  'С',
  'Т',
  'У',
  'Ү',
  'Ф',
  'Х',
  'Ц',
  'Ч',
  'Ш',
  'Щ',
  'Ъ',
  'Ы',
  'Ь',
  'Э',
  'Ю',
  'Я'
];

const dummy =
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.";
