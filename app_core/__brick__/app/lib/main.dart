import 'package:flutter/material.dart';
import 'core/extension/shared_preferences_manager.dart';
import 'core/l10n/l10n.dart';
import 'core/locator/locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/router/router.dart';
import 'core/utils/custom_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

SharedPreferencesManager sharedPreferencesManager = locator();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjection();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocal) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocal);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale value) {
    setState(() {
      _locale = value;
      sharedPreferencesManager.setCurrentLanguage(_locale!.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      title: 'Marker App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      routerConfig: router,
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: CustomColor.white),
        scaffoldBackgroundColor: CustomColor.white,
      ),
      locale: Locale(sharedPreferencesManager.getCurrentLanguage() ?? 'en'),
    );
  }
}
