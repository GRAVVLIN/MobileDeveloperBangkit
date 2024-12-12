part of 'theme_bloc.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.initial(ThemeMode themeMode) = _Initial;
  const factory ThemeState.loaded(ThemeMode themeMode) = _Loaded;
} 