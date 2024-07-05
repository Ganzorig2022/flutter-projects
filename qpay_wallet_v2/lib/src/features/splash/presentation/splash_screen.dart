import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qpay_wallet_v2/src/routing/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routePath = '/';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => {
        // FocusManager.instance.primaryFocus?.unfocus()
        context.goNamed(AppRoute.home.name)
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned.fill(
            child: Center(
              child: Image.asset(
                'assets/splash.jpg',
                height: size.height,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            child: Image.asset(
              'assets/loader.gif',
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 40,
            child: Image.asset(
              'assets/slogan.png',
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
