import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/auth/pages/login_page.dart';
import '../../presentation/auth/pages/register_page.dart';
import '../../presentation/dashboard/pages/activity_page.dart';
import '../../presentation/dashboard/pages/dashboard_page.dart';
import '../../presentation/dashboard/pages/home_page.dart';
import '../../presentation/root/splash_screen.dart';
import '../../presentation/transaction/pages/input_amount_page.dart';
import '../../presentation/transaction/pages/saving_selection_page.dart';
import '../../presentation/root/onboarding/pages/onboarding_page.dart';
part 'route_constants.dart';
part 'enums/root_tab.dart';
part 'models/path_parameters.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          if (state.fullPath?.contains('root_tab') ?? false) {
            final tab = int.tryParse(state.pathParameters['root_tab'] ?? '0') ?? 0;
            return DashboardPage(currentTab: tab);
          }
          return child;
        },
        routes: [
          GoRoute(
            path: '/home/:root_tab',
            name: RouteConstants.root,
            builder: (context, state) {
              final tab = int.parse(state.pathParameters['root_tab'] ?? '0');
              return const HomePage();
            },
          ),
          GoRoute(
            path: RouteConstants.activityPath,
            name: RouteConstants.activity,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ActivityPage(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/splash',
        name: RouteConstants.splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: RouteConstants.onBoardingPath,
        name: RouteConstants.onBoarding,
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        name: RouteConstants.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: RouteConstants.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/input-amount',
        name: RouteConstants.inputAmount,
        builder: (context, state) => const InputAmountPage(),
      ),
      GoRoute(
        path: '/saving-selection',
        name: RouteConstants.savingSelection,
        builder: (context, state) => SavingSelectionPage(
          amount: state.extra as int,
        ),
      ),
    ],
  );
}
