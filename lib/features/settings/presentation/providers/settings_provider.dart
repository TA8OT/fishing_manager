import 'package:fishing_app/features/settings/data/models/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_notifier.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);
