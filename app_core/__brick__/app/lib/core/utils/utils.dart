import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import '../error_handling/custom_exception.dart';
import '../error_handling/failure.dart';
import 'constants.dart';
import 'custom_colors.dart';
import '../widget/custom_elevated_button.dart';
import '../../main.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class Utils {
  static Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return '';
  }

  static String setNumberFont() {
    if (sharedPreferencesManager.getCurrentLanguage() == 'fa' ||
        sharedPreferencesManager.getCurrentLanguage() == 'ar' ||
        sharedPreferencesManager.getCurrentLanguage() == 'ku') {
      return '\u06f0';
    } else {
      return '0';
    }
  }

  static bool isRTL() {
    if (sharedPreferencesManager.getCurrentLanguage() == 'fa' ||
        sharedPreferencesManager.getCurrentLanguage() == 'ar' ||
        sharedPreferencesManager.getCurrentLanguage() == 'ku') {
      return true;
    } else {
      return false;
    }
  }

  static void showConfirmDialog({
    required String message,
    required String title,
    required Function() onConfirm,
    required Function() onRefresh,
    required BuildContext context,
  }) {
    // final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => ScaffoldMessenger(
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {}
                },
                child: Dialog(
                  backgroundColor: CustomColor.white,
                  surfaceTintColor: CustomColor.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (title.isNotEmpty)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: CustomColor.gray_dark),
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: CustomColor.gray_medium_dark,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(message),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        backgroundColor: CustomColor.yellow,
                                        onTap: () async {
                                          context.pop();
                                          onConfirm();
                                        },
                                        child: const Text(
                                          '  appLocalizations.confirm',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        backgroundColor: Colors.red,
                                        onTap: () async {
                                          context.pop();
                                        },
                                        child: const Text(
                                          ' appLocalizations.cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    ).then((value) {
      onRefresh();
    });
  }

  static String getLanguageForKurdish() {
    if (sharedPreferencesManager.getCurrentLanguage() == 'ps') {
      return 'ku';
    } else {
      return sharedPreferencesManager.getCurrentLanguage() ?? 'en';
    }
  }

  static void showSnack({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.red,
        backgroundColor: CustomColor.yellow,
        duration: const Duration(seconds: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<String> getDeviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    }
    return '';
  }

  static Future<String> getDeviceOsVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.systemName;
    }
    return '';
  }

  static String timeFormatter(String value, bool formatNumber) {
    late String hour;
    late String minutes;

    if (value.contains('z') || value.contains('Z')) {
      hour =
          DateTime.parse(value).toLocal().toIso8601String().substring(11, 13);
      minutes =
          DateTime.parse(value).toLocal().toIso8601String().substring(14, 16);
    } else {
      hour = DateTime.parse('${value}z')
          .toLocal()
          .toIso8601String()
          .substring(11, 13);
      minutes = DateTime.parse('${value}z')
          .toLocal()
          .toIso8601String()
          .substring(14, 16);
    }
    if (formatNumber) {
      hour = NumberFormat('##', sharedPreferencesManager.getCurrentLanguage())
          .format(int.parse(hour));
      minutes =
          NumberFormat('##', sharedPreferencesManager.getCurrentLanguage())
              .format(int.parse(minutes));
      if (hour.length == 1) {
        hour =
            '${NumberFormat('#', sharedPreferencesManager.getCurrentLanguage()).format(int.parse('0'))}$hour';
      }
      if (minutes.length == 1) {
        minutes =
            '${NumberFormat('#', sharedPreferencesManager.getCurrentLanguage()).format(int.parse('0'))}$minutes';
      }
    }
    return '$hour:$minutes';
  }

  static String dateFormatter(String value, {bool formatLanguage = true}) {
    late String year;
    late String month;
    late String day;
    // if (sharedPreferencesManager.isJalali()) {
    //   year = Jalali.fromDateTime(DateTime.parse(value)).formatter.yyyy;
    //   month = Jalali.fromDateTime(DateTime.parse(value)).formatter.mm;
    //   day = Jalali.fromDateTime(DateTime.parse(value)).formatter.dd;
    // } else {
    //   year = Gregorian.fromDateTime(DateTime.parse(value)).formatter.yyyy;
    //   month = Gregorian.fromDateTime(DateTime.parse(value)).formatter.mm;
    //   day = Gregorian.fromDateTime(DateTime.parse(value)).formatter.dd;
    // }
    year = (DateTime.parse(value)).year.toString();
    month = (DateTime.parse(value)).month.toString();
    day = (DateTime.parse(value)).day.toString();
    if (formatLanguage) {
      year = NumberFormat('####', sharedPreferencesManager.getCurrentLanguage())
          .format(int.parse(year));
      month = NumberFormat('##', sharedPreferencesManager.getCurrentLanguage())
          .format(int.parse(month));
      day = NumberFormat('##', sharedPreferencesManager.getCurrentLanguage())
          .format(int.parse(day));

      if (day.length == 1) {
        day =
            '${NumberFormat('#', sharedPreferencesManager.getCurrentLanguage()).format(int.parse('0'))}$day';
      }
      if (month.length == 1) {
        month =
            '${NumberFormat('#', sharedPreferencesManager.getCurrentLanguage()).format(int.parse('0'))}$month';
      }
    }
    return '$year/$month/$day';
  }

  static Future<String> getDeviceBrand() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.brand;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
    return '';
  }

  static Future<geo.Position?> getUserGeoLocation() async {
    try {
      Location location = Location();
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Error();
        }
      }

      if (serviceEnabled) {
        var permission = await geo.Geolocator.checkPermission();

        if (permission == geo.LocationPermission.denied) {
          permission = await geo.Geolocator.requestPermission();
          if (permission == geo.LocationPermission.denied) {
            throw Error();
          }
        }
        try {
          final location = await geo.Geolocator.getCurrentPosition(
            forceAndroidLocationManager: false,
            timeLimit: const Duration(seconds: 20),
            desiredAccuracy: geo.LocationAccuracy.best,
          );

          return location;
        } catch (e) {
          try {
            final location = await geo.Geolocator.getCurrentPosition(
              forceAndroidLocationManager: true,
              timeLimit: const Duration(seconds: 20),
              desiredAccuracy: geo.LocationAccuracy.best,
            );

            return location;
          } catch (e) {
            throw Error();
          }
        }
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  static handleUnknownException(Object e) {
    if (e is CancelByUserException) {
      return CancelByUserFailure();
    }
    if (e is TypeError) {
      return TypeErrorFailure(message: e.toString());
    }
    return UnknownFailure();
  }

  // static handleDioException(DioException e) {
  //   if (e.isNoConnectionError) {
  //     throw NoInternetConnectionException();
  //   } else if (e.response != null) {
  //     throw RestApiException(
  //         e.response?.statusCode, (e.response ?? e.message).toString());
  //   } else if (e.type == DioExceptionType.cancel) {
  //     throw CancelByUserException(errorMessage: e.message, errorCode: 499);
  //   } else if (e.type == DioExceptionType.cancel) {
  //     throw CancelByUserException();
  //   } else {
  //     throw UnknownException();
  //   }
  // }

  // static handleRestApiException(RestApiException e) {
  //   if (e.errorCode != null) {
  //     if (e.errorCode! >= RestApiError.FROM_SERVER_ERROR &&
  //         e.errorCode! <= RestApiError.TO_SERVER_ERROR) {
  //       return ServerErrorFailure(
  //           errorCode: e.errorCode, message: e.errorMessage);
  //     }
  //     if (e.errorCode! == 403 || e.errorCode == 401) {
  //       return UnauthorizedFailure(
  //           errorCode: e.errorCode, message: e.errorMessage);
  //     }
  //     return UnknownFailure(errorCode: e.errorCode, message: e.errorMessage);
  //   } else {
  //     return UnknownFailure(errorCode: e.errorCode, message: e.errorMessage);
  //   }
  // }
}
