import 'theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_state.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  ThemeNotifier.new,
);
