import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fishing_app/app/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fishing_app/app/theme/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:fishing_app/features/settings/presentation/providers/settings_provider.dart';

class FishingManagerApp extends ConsumerWidget {
  const FishingManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settings.languageCode),

      title: l10n?.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: themeState.mode,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
