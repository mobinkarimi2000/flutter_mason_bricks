import 'dart:io';
import '../extension/shared_preferences_manager.dart';
import '../../main.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;
setupInjection() async {
  await provideSharedPreferences();
  provideSharedPreferencesManager();
  provideDioBaseOptions();
  provideDio();
}

void provideSharedPreferencesManager() {
  final sharedPreferencesManager = SharedPreferencesManager(locator());
  locator.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager);
}

Future<void> provideSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
}
