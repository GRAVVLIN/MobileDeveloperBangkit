import 'package:ez_money_app/presentation/statistics/pages/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ez_money_app/core/core.dart'; 
import 'package:ez_money_app/presentation/dashboard/pages/home_page.dart';
import 'package:ez_money_app/presentation/transaction/pages/create_transaction_sheet.dart';
import 'package:ez_money_app/presentation/dashboard/pages/activity_page.dart';
import 'package:ez_money_app/presentation/auth/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;
  const DashboardPage({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _selectedIndex;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    _selectedIndex = widget.currentTab;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: _getPage(_selectedIndex),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const CreateTransactionSheet(),
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.black : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 25,
          ),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            tabBorderRadius: 15,
            duration: const Duration(milliseconds: 200),
            gap: 8,
            color: isDarkMode ? AppColors.white : AppColors.black,
            activeColor: AppColors.black,
            iconSize: 24,
            tabBackgroundColor: isDarkMode
                ? AppColors.white
                : AppColors.primary.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: _selectedIndex == 0
                      ? Assets.icons.home.svg()
                      : Assets.icons.home.svg(
                          colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 172, 172, 172),
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
              GButton(
                icon: Icons.local_activity,
                text: 'Activity',
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: _selectedIndex == 1
                      ? Assets.icons.activity.svg()
                      : Assets.icons.activity.svg(
                          colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 172, 172, 172),
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Statistic',
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: _selectedIndex == 2
                      ? Assets.icons.statistic.svg()
                      : Assets.icons.statistic.svg(
                          colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 172, 172, 172),
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: _selectedIndex == 3
                      ? Assets.icons.profileUser.svg()
                      : Assets.icons.profileUser.svg(
                          colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 172, 172, 172),
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage(key: PageStorageKey('HomePage'));
      case 1:
        return const ActivityPage(key: PageStorageKey('ActivityPage'));
      case 2:
        return const StatisticsPage(key: PageStorageKey('StatisticsPage'));
      case 3:
        return const ProfilePage(key: PageStorageKey('ProfilePage'));
      default:
        return const HomePage(key: PageStorageKey('HomePage'));
    }
  }
}
