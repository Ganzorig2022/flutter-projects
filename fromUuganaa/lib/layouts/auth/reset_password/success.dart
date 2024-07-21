import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/layouts/auth/login.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';

class ResetSuccessPage extends StatelessWidget {
  const ResetSuccessPage({super.key});
  static String route = '/reset_success_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryButton(
                label: 'Нэвтрэх',
                onPressed: () {
                  MyRouter.offNamedUntil(Login.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
