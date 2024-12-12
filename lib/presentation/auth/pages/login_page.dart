import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';
import '../../dashboard/bloc/transaction_list/transaction_list_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/show_alert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/datasources/transaction_local_datasource.dart'; 
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  // Tambahkan FocusNode
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  // Tambahkan AnimationController
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  bool _rememberEmail = false;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    _loadSavedEmail();

    // Setup animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    // Add listeners untuk animasi focus
    emailFocus.addListener(() {
      setState(() {});
    });
    passwordFocus.addListener(() {
      setState(() {});
    });
  }

  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    if (savedEmail != null && savedEmail.isNotEmpty) {
      setState(() {
        emailController.text = savedEmail;
        _rememberEmail = true;
      });
    }
  }

  Future<void> _saveEmail() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberEmail) {
      await prefs.setString('saved_email', emailController.text);
    } else {
      await prefs.remove('saved_email');
    }
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _unfocusAll() {
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Definisikan warna adaptif
    final backgroundColor = isDarkMode ? AppColors.black : AppColors.white;
    final textColor = isDarkMode ? AppColors.white : AppColors.primary;
    final secondaryTextColor =
        isDarkMode ? AppColors.grey : AppColors.secondary;
    final inputFillColor =
        isDarkMode ? AppColors.grey.withOpacity(0.1) : AppColors.light;
    final cardColor =
        isDarkMode ? AppColors.grey.withOpacity(0.1) : AppColors.white;

    return GestureDetector(
      onTap: _unfocusAll,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (data) async {
                await AuthLocalDatasource().saveAuthData(data);
                if (mounted) {
                  // Clear transaction cache first
                  await TransactionLocalDatasource().clearCache();
                  final userId = data.userId;
                  showAlert(
                    context: context,
                    message: 'Login Berhasil!',
                    dialogType: DialogType.success,
                    autoDismiss: true,
                    btnOkOnPress: () {
                      // Navigate and trigger transaction refresh
                      context.read<TransactionListBloc>().add(
                        TransactionListEvent.refreshTransactions(
                          userId: userId!,
                          month: DateFormat('yyyy-MM').format(DateTime.now()),
                        ),
                      );
                      context.goNamed(
                        RouteConstants.root,
                        pathParameters: {'root_tab': '0'},
                      );
                    },
                  );
                }
              },
              error: (message) {
                showAlert(
                  context: context,
                  message: message,
                  dialogType: DialogType.error,
                  autoDismiss: true,
                );
              },
            );
          },
          child: SafeArea(
            child: AutofillGroup(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.height * 0.04,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.04),
                          // Logo Section dengan efek gradient dan shadow
                          Center(
                            child: Assets.images.logoEzmoneyNoTitle.image(
                              width: size.width * 0.5,
                              height: size.width * 0.5,
                            ),
                          ),

                          SizedBox(height: size.height * 0.05),

                          // Header Section dengan animasi subtle
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 800),
                            tween: Tween(begin: 0, end: 1),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: child,
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selamat Datang",
                                  style: TextStyle(
                                    fontSize: size.width * 0.08,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  "Silakan masuk ke akun Anda",
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: secondaryTextColor,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: size.height * 0.05),

                          // Form fields dengan animasi yang lebih smooth
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset:
                                    Offset(0, (1 - _fadeAnimation.value) * 30),
                                child: child,
                              );
                            },
                            child: Column(
                              children: [
                                // Email field
                                _buildTextField(
                                  controller: emailController,
                                  focusNode: emailFocus,
                                  label: "Email",
                                  hint: "Masukkan email anda",
                                  icon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocus);
                                  },
                                  textColor: textColor,
                                  secondaryTextColor: secondaryTextColor,
                                  backgroundColor: backgroundColor,
                                  fillColor: inputFillColor,
                                ),
                                SizedBox(height: size.height * 0.02),

                                // Password field
                                _buildTextField(
                                  controller: passwordController,
                                  focusNode: passwordFocus,
                                  label: "Password",
                                  hint: "Masukkan password anda",
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _unfocusAll();
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                            LoginEvent.login(
                                              emailController.text,
                                              passwordController.text,
                                            ),
                                          );
                                    }
                                  },
                                  textColor: textColor,
                                  secondaryTextColor: secondaryTextColor,
                                  backgroundColor: backgroundColor,
                                  fillColor: inputFillColor,
                                ),
                                SizedBox(height: size.height * 0.02),

                                // Remember Email & Forgot Password in one row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Remember Email
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Checkbox(
                                            value: _rememberEmail,
                                            onChanged: (value) {
                                              setState(() {
                                                _rememberEmail = value ?? false;
                                              });
                                            },
                                            activeColor: textColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Ingat Email',
                                          style: TextStyle(
                                            color: secondaryTextColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Forgot Password
                                    TextButton(
                                      onPressed: () {
                                        // Handle forgot password
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: textColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                      ),
                                      child: Text(
                                        'Lupa Password?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: size.height * 0.04),

                          // Login Button dengan animasi dan efek hover
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: ElevatedButton(
                                    onPressed: state.maybeWhen(
                                      loading: () => null,
                                      orElse: () => () async {
                                        if (_formKey.currentState!.validate()) {
                                          // Save email if remember is checked
                                          await _saveEmail();

                                          context.read<LoginBloc>().add(
                                                LoginEvent.login(
                                                  emailController.text,
                                                  passwordController.text,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: textColor,
                                      foregroundColor: backgroundColor,
                                      minimumSize: Size(
                                        double.infinity,
                                        size.height * 0.06,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.02,
                                      ),
                                    ),
                                    child: state.maybeWhen(
                                      loading: () => const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      orElse: () => Text(
                                        "Masuk",
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: size.height * 0.03),

                          // Register Link dengan animasi hover
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Belum punya akun? ",
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: TextButton(
                                    onPressed: () => context
                                        .pushNamed(RouteConstants.register),
                                    style: TextButton.styleFrom(
                                      foregroundColor: secondaryTextColor,
                                    ),
                                    child: Text(
                                      "Daftar Sekarang",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.035,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Updated _buildTextField method
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Function(String)? onFieldSubmitted,
    required Color textColor,
    required Color secondaryTextColor,
    required Color backgroundColor,
    required Color fillColor,
  }) {
    String? validateField(String? value) {
      if (value == null || value.isEmpty) {
        return '$label tidak boleh kosong';
      }

      if (label == "Email") {
        // Validasi email
        final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegExp.hasMatch(value)) {
          return 'Format email tidak valid';
        }
      }

      return null;
    }

    final bool isFocused = focusNode.hasFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.translationValues(0, isFocused ? -4 : 0, 0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword && !_isPasswordVisible,
        keyboardType: label == "Email"
            ? TextInputType.emailAddress
            : (isPassword ? TextInputType.visiblePassword : keyboardType),
        textInputAction: textInputAction,
        autocorrect: !isPassword,
        enableSuggestions: !isPassword,
        autofillHints: label == "Email"
            ? [AutofillHints.email, AutofillHints.username]
            : isPassword
                ? [AutofillHints.password]
                : null,
        textCapitalization: label == "Email"
            ? TextCapitalization.none
            : TextCapitalization.sentences,
        onEditingComplete: () {
          if (label == "Email") {
            TextInput.finishAutofillContext();
            FocusScope.of(context).requestFocus(passwordFocus);
          }
        },
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: isFocused ? FontWeight.w500 : FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isFocused ? textColor : secondaryTextColor,
            fontSize: isFocused ? 14 : 16,
          ),
          hintText: hint,
          hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
          prefixIcon: Icon(
            icon,
            color: isFocused ? textColor : secondaryTextColor,
          ),
          suffixIcon: label == "Email" && controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: isFocused ? textColor : secondaryTextColor,
                  ),
                  onPressed: () {
                    controller.clear();
                    setState(() {
                      _rememberEmail = false;
                    });
                  },
                )
              : isPassword
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: isFocused ? textColor : secondaryTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
          filled: true,
          fillColor: isFocused ? fillColor : backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isFocused ? textColor : secondaryTextColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: secondaryTextColor.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: textColor, width: 1.5),
          ),
          errorStyle: TextStyle(
            color: Colors.red[700],
            fontSize: 12,
          ),
          errorMaxLines: 2, // Untuk pesan error yang panjang
        ),
        validator: validateField,
        onChanged: (value) {
          // Trigger validasi saat user mengetik
          if (_formKey.currentState != null) {
            _formKey.currentState!.validate();
          }
        },
      ),
    );
  }
}
