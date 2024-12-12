import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ez_money_app/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/router/app_router.dart';
import '../../data/datasources/auth_local_datasource.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final isFirstInstall = prefs.getBool('isFirstInstall') ?? true;

    if (isFirstInstall) {
      if (!mounted) return;
      context.goNamed(RouteConstants.onBoarding);
      return;
    }

    final isAuth = await AuthLocalDatasource().isAuth();
    if (isAuth) {
      if (!mounted) return;
      context.goNamed(RouteConstants.root, pathParameters: {'root_tab': '0'});
    } else {
      if (!mounted) return;
      context.goNamed(RouteConstants.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: context.width,
            color: AppColors.white,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.logoEzmoney.path),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 360,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.purple.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
