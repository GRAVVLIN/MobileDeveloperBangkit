import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ez_money_app/core/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../core/utils/jwt_helper.dart';
import '../../theme/bloc/theme_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.token != null) {
      final payload = JwtHelper.parseJwt(authData!.token!);
      setState(() {
        username = payload['username'] ?? payload['name'];
        email = payload['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color:
                  isDarkMode ? AppColors.grey.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Avatar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode
                        ? AppColors.primary.withOpacity(0.2)
                        : AppColors.primary.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 64,
                    color: isDarkMode ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                // User Info
                Text(
                  username ?? 'User',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : AppColors.primary,
                  ),
                ),
                if (email != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    email!,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Settings Section
          Container(
            decoration: BoxDecoration(
              color:
                  isDarkMode ? AppColors.grey.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : AppColors.primary,
                    ),
                  ),
                ),
                const Divider(height: 1),
                // Theme Toggle
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    final isDarkMode = state.when(
                      initial: (themeMode) => themeMode == ThemeMode.dark,
                      loaded: (themeMode) => themeMode == ThemeMode.dark,
                    );

                    return _buildSettingsTile(
                      icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      title: 'Dark Mode',
                      trailing: Switch.adaptive(
                        value: isDarkMode,
                        onChanged: (_) {
                          context.read<ThemeBloc>().add(
                                const ThemeEvent.toggleTheme(),
                              );
                        },
                        activeColor:
                            isDarkMode ? Colors.white : AppColors.primary,
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                // Logout Button
                _buildSettingsTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // App Info Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  isDarkMode ? AppColors.grey.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Info',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Version', '1.0.0'),
                const SizedBox(height: 8),
                _buildInfoRow('Build', 'Minggu, 08 Desember 2024'),
                const SizedBox(height: 8),
                _buildInfoRow('Developer', 'EzMoney Company'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? iconColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? (isDarkMode ? Colors.white : AppColors.primary),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? (isDarkMode ? Colors.white : Colors.black87),
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color:
                isDarkMode ? Colors.white.withOpacity(0.7) : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor:
            isDarkMode ? AppColors.grey.withOpacity(0.1) : Colors.white,
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              
              await AuthLocalDatasource().removeAuthData();
              
              if (!mounted) return;
              
              showAlert(
                context: context,
                message: 'Logout success',
                dialogType: DialogType.success,
                btnOkOnPress: () {
                  context.goNamed('login');
                },
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
