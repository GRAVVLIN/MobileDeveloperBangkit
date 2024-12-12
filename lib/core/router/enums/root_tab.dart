part of '../app_router.dart';

enum RootTab {
  home('0'),
  activity('1'),
  statistic('2'),
  profile('3');

  final String value;
  const RootTab(this.value);

  factory RootTab.fromIndex(int index) {
    return values.firstWhere(
      (value) => value.value == '$index',
      orElse: () => RootTab.home,
    );
  }
}
