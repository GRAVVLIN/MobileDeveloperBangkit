import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/core.dart';
import 'core/router/app_router.dart';
import 'data/datasources/analytics_local_datasource.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/transaction_local_datasource.dart';
import 'data/datasources/transaction_remote_datasource.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/logout/logout_bloc.dart';
import 'presentation/auth/bloc/register/register_bloc.dart';
import 'presentation/transaction/bloc/transaction/transaction_bloc.dart';
import 'presentation/dashboard/bloc/transaction_list/transaction_list_bloc.dart';
import 'presentation/theme/bloc/theme_bloc.dart';
import 'presentation/statistics/bloc/analytics_bloc.dart';
import 'data/datasources/analytics_remote_datasource.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(
            TransactionRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => TransactionListBloc(
            TransactionRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AnalyticsBloc(
            AnalyticsRemoteDatasource(),
            AnalyticsLocalDatasource(),
            TransactionRemoteDatasource(),
            TransactionLocalDatasource(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final themeMode = state.maybeWhen(
          orElse: () => ThemeMode.light,
          loaded: (mode) => mode,
        );

        return MaterialApp.router(
          title: 'EZ Money App',
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.dark,
            ),
          ),
          routerConfig: AppRouter().router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', 'ID'),
            Locale('en', 'US'),
          ],
        );
      },
    );
  }
}
