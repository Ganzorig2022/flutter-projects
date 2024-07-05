import 'package:cashapp/components/loader.dart';
import 'package:cashapp/components/num_pad.dart';
import 'package:cashapp/layouts/auth/login.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';

class CreatePinCode extends StatefulWidget {
  const CreatePinCode({super.key});
  static String route = '/create_pincode';

  @override
  State<CreatePinCode> createState() => _CreatePinCodeState();
}

class _CreatePinCodeState extends State<CreatePinCode> {
  bool loading = false;
  PageController pageController = PageController();
  final int pinLength = 4;
  String pinCode = '';

  createPin() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => loading = false);
    if (true) {
      MyRouter.offNamedUntil(Login.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: PageView(
                pageSnapping: true,
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  NumPad(
                    pinLength: pinLength,
                    title: 'Гүйлгээний пин кодоо үүсгэнэ үү',
                    onCompleted: (value) async {
                      if (value.length == pinLength) {
                        setState(() => pinCode = value);
                        pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease,
                        );
                        return true;
                      } else {
                        return false;
                      }
                    },
                  ),
                  NumPad(
                    pinLength: pinLength,
                    title: 'Гүйлгээний пин код давтах',
                    onCompleted: (value) async {
                      if (pinCode == value) {
                        createPin();
                        return true;
                      } else {
                        return false;
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        if (loading) const Loader(),
      ],
    );
  }
}
