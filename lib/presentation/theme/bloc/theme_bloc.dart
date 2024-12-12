import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState.initial(ThemeMode.light)) {
    on<_Started>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(themeKey) ?? false;
      emit(ThemeState.loaded(isDark ? ThemeMode.dark : ThemeMode.light));
    });

    on<_ToggleTheme>((event, emit) async {
      final currentState = state;
      if (currentState is _Loaded) {
        final newTheme = currentState.themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(themeKey, newTheme == ThemeMode.dark);
        emit(ThemeState.loaded(newTheme));
      }
    });

    add(const ThemeEvent.started());
  }
} 