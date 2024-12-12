import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/router/app_router.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../dashboard/bloc/transaction_list/transaction_list_bloc.dart';
import '../bloc/register/register_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/show_alert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../data/datasources/transaction_local_datasource.dart'; 

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Tambahkan FocusNode
  late FocusNode usernameFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  // Tambahkan AnimationController
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    // Add listeners
    usernameFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    _animationController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _unfocusAll() {
    usernameFocus.unfocus();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => context.goNamed(RouteConstants.login),
          ),
        ),
        body: BlocListener<RegisterBloc, RegisterState>(
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
                    message: 'Register Berhasil!',
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
                      // input amount page no back page
                      context.pushNamed(
                        RouteConstants.inputAmount,

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
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.height * 0.02,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo Section dengan warna adaptif
                        Center(
                          child: Container(
                            width: size.width * 0.25,
                            height: size.width * 0.25,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  textColor,
                                  textColor.withOpacity(0.8),
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: textColor.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_add_outlined,
                              size: size.width * 0.12,
                              color: backgroundColor,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        // Header Section dengan warna adaptif
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
                                "Buat Akun Baru",
                                style: TextStyle(
                                  fontSize: size.width * 0.08,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                "Mulai perjalanan finansial Anda bersama kami",
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: secondaryTextColor,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        // Form Fields dengan warna adaptif
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
                              _buildTextField(
                                controller: usernameController,
                                focusNode: usernameFocus,
                                label: "Username",
                                hint: "Masukkan username anda",
                                icon: Icons.person_outline,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocus);
                                },
                                textColor: textColor,
                                secondaryTextColor: secondaryTextColor,
                                backgroundColor: backgroundColor,
                                fillColor: inputFillColor,
                              ),
                              SizedBox(height: size.height * 0.02),
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
                              _buildTextField(
                                controller: passwordController,
                                focusNode: passwordFocus,
                                label: "Password",
                                hint: "Masukkan password yang kuat",
                                icon: Icons.lock_outline,
                                isPassword: true,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  _unfocusAll();
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RegisterBloc>().add(
                                          RegisterEvent.register(
                                            username: usernameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                  }
                                },
                                textColor: textColor,
                                secondaryTextColor: secondaryTextColor,
                                backgroundColor: backgroundColor,
                                fillColor: inputFillColor,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        // Register Button dengan warna adaptif
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                child: ElevatedButton(
                                  onPressed: state.maybeWhen(
                                    loading: () => null,
                                    orElse: () => () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<RegisterBloc>().add(
                                              RegisterEvent.register(
                                                username:
                                                    usernameController.text,
                                                email: emailController.text,
                                                password:
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
                                    loading: () => SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: backgroundColor,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    orElse: () => Text(
                                      "Daftar",
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

                        // Login Link dengan warna adaptif
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sudah punya akun? ",
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: size.width * 0.035,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: TextButton(
                                  onPressed: () => context.goNamed(RouteConstants.login),
                                  style: TextButton.styleFrom(
                                    foregroundColor: secondaryTextColor,
                                  ),
                                  child: Text(
                                    "Masuk Sekarang",
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
    );
  }

  // Helper method untuk membuat text field yang konsisten
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
    final bool isFocused = focusNode.hasFocus;

    String? validateField(String? value) {
      if (value == null || value.isEmpty) {
        return '$label tidak boleh kosong';
      }

      switch (label) {
        case "Username":
          if (value.length < 4) {
            return 'Username minimal 4 karakter';
          }
          if (value.length > 20) {
            return 'Username maksimal 20 karakter';
          }
          // if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
          //   return 'Username hanya boleh huruf, angka, dan underscore';
          // }
          break;

        case "Email":
          final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegExp.hasMatch(value)) {
            return 'Format email tidak valid';
          }
          break;

        case "Password":
          if (value.length < 8) {
            return 'Password minimal 8 karakter';
          }
          if (!value.contains(RegExp(r'[A-Z]'))) {
            return 'Password harus mengandung huruf besar';
          }
          if (!value.contains(RegExp(r'[a-z]'))) {
            return 'Password harus mengandung huruf kecil';
          }
          if (!value.contains(RegExp(r'[0-9]'))) {
            return 'Password harus mengandung angka';
          }
          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
            return 'Password harus mengandung karakter spesial';
          }
          break;
      }
      return null;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.translationValues(0, isFocused ? -4 : 0, 0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword && !_isPasswordVisible,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: isFocused ? FontWeight.w500 : FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: secondaryTextColor,
            fontSize: 16,
          ),
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.7)),
          prefixIcon: Icon(
            icon,
            color: secondaryTextColor,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: secondaryTextColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: secondaryTextColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: secondaryTextColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorStyle: TextStyle(
            color: Colors.red[700],
            fontSize: 12,
          ),
          errorMaxLines: 3, // Untuk pesan error yang panjang
          // Tambahkan helper text untuk password
          helperText: label == "Password"
              ? 'Min. 8 karakter, huruf besar & kecil, angka, dan karakter spesial'
              : null,
          helperStyle: TextStyle(
            color: secondaryTextColor.withOpacity(0.7),
            fontSize: 11,
          ),
          helperMaxLines: 2,
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
