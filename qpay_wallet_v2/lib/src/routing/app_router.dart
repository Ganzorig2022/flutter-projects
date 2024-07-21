// import 'package:qpay_wallet/src/features/authentication/data/fake_auth_repository.dart';
// import 'package:qpay_wallet/src/features/authentication/presentation/account/account_screen.dart';
// import 'package:qpay_wallet/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
// import 'package:qpay_wallet/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
// import 'package:qpay_wallet/src/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
// import 'package:qpay_wallet/src/features/checkout/presentation/checkout_screen/checkout_screen.dart';
// import 'package:qpay_wallet/src/features/orders/presentation/orders_list/orders_list_screen.dart';
// import 'package:qpay_wallet/src/features/products/presentation/product_screen/product_screen.dart';
// import 'package:qpay_wallet/src/features/products/presentation/products_list/products_list_screen.dart';
// import 'package:qpay_wallet/src/features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import 'package:qpay_wallet_v2/src/features/home/presentation/home_screen.dart';
import 'package:qpay_wallet_v2/src/routing/go_router_refresh_stream.dart';
import 'package:qpay_wallet_v2/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpay_wallet_v2/src/routing/go_router_refresh_stream.dart';
import 'package:qpay_wallet_v2/src/routing/not_found_screen.dart';
import 'package:qpay_wallet_v2/src/features/splash/presentation/splash_screen.dart';

enum AppRoute {
  splash,
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  // final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      // final isLoggedIn = authRepository.currentUser != null;
      // final path = state.uri.path;
      // if (isLoggedIn) {
      //   if (path == '/signIn') {
      //     return '/';
      //   }
      // } else {
      //   if (path == '/account' || path == '/orders') {
      //     return '/';
      //   }
      // }
      return null;
    },
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: SplashScreen.routePath,
        // name: AppRoute.home.name,
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: 'home',
            name: AppRoute.home.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: HomeScreen(),
            ),
          ),
          // GoRoute(
          //   path: 'cart',
          //   name: AppRoute.cart.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: ShoppingCartScreen(),
          //   ),
          //   routes: [
          //     GoRoute(
          //       path: 'checkout',
          //       name: AppRoute.checkout.name,
          //       pageBuilder: (context, state) => const MaterialPage(
          //         fullscreenDialog: true,
          //         child: CheckoutScreen(),
          //       ),
          //     ),
          //   ],
          // ),
          // GoRoute(
          //   path: 'orders',
          //   name: AppRoute.orders.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: OrdersListScreen(),
          //   ),
          // ),
          // GoRoute(
          //   path: 'account',
          //   name: AppRoute.account.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: AccountScreen(),
          //   ),
          // ),
          // GoRoute(
          //   path: 'signIn',
          //   name: AppRoute.signIn.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: EmailPasswordSignInScreen(
          //       formType: EmailPasswordSignInFormType.signIn,
          //     ),
          //   ),
          // ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
