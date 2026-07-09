import 'package:fishing_app/features/settings/data/models/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    return const AppSettings(languageCode: 'en', currencyCode: 'USD');
  }

  void changeLanguage(String languageCode) {
    state = AppSettings(
      languageCode: languageCode,
      currencyCode: state.currencyCode,
    );
  }

  void changeCurrency(String currencyCode) {
    state = AppSettings(
      languageCode: state.languageCode,
      currencyCode: currencyCode,
    );
  }
}
