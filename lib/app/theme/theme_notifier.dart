import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'theme_state.dart';

class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() {
    return ThemeState(mode: ThemeMode.system);
  }

  void changeTheme(ThemeMode mode) {
    state = ThemeState(mode: mode);
  }
}
