import 'package:ez_money_app/core/components/spaces.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_indicator.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  final _pageController = PageController();

  final onboardingData = [
    OnboardingModel(
      image: Assets.images.logoEzmoneyNoTitle.path,
      title: 'Selamat Datang di',
      desc: 'Kelola keuanganmu dengan mudah, cerdas, dan sesuai kebutuhanmu',
    ),
    OnboardingModel(
      image: Assets.images.track.path,
      title: 'Kelola Keuanganmu',
      desc: 'Catat setiap pemasukan dan pengeluaran, kapan saja, dimana saja',
    ),
    OnboardingModel(
      image: Assets.images.heart.path,
      title: 'Atur Keuanganmu Sesuai dengan Gaya Hidupmu',
      desc:
          'Pilih strategi pengelolaan keuangan yang sesuai dengan pendapatan dan tujuan mu.',
    ),
    OnboardingModel(
      image: Assets.images.monitor.path,
      title: 'Pantau Progres Tabunganmu',
      desc:
          'Capai tujuan keuanganmu lebih cepat dengan analisis bulanan dan laporan.',
    ),
    OnboardingModel(
      title: 'Siap untuk Mengubah Keuanganmu?',
      desc: 'Mulai perjalanan keuanganmu dan buat hidup lebih teratur.',
    ),
  ];

  void _finishOnBoarding(BuildContext context, String routeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstInstall', false);

    if (!mounted) return;

    context.goNamed(routeName);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
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
                      Colors.purple.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                OnboardingContent(
                  pageController: _pageController,
                  onPageChanged: (index) {
                    currentPage = index;
                    setState(() {});
                  },
                  contents: onboardingData,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: currentPage < onboardingData.length - 1
                      ? Button.filled(
                          onPressed: () {
                            if (currentPage < onboardingData.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              currentPage++;
                              setState(() {});
                            }
                          },
                          label: 'Lanjut',
                        )
                      : Column(
                          children: [
                            Button.filled(
                              onPressed: () {
                                _finishOnBoarding(
                                    context, RouteConstants.login);
                              },
                              label: 'Masuk',
                              width: double.infinity * .3,
                            ),
                            SpaceHeight(10),
                            Button.outlined(
                              onPressed: () {
                                _finishOnBoarding(
                                    context, RouteConstants.register);
                              },
                              label: 'Daftar',
                              width: double.infinity * .8,
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 10),
                OnboardingIndicator(
                  length: onboardingData.length,
                  currentPage: currentPage,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
