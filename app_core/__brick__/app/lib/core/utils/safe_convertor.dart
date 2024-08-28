import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class SafeConvertor {
  static int asInt(Map<String, dynamic>? json, String key,
      {int defaultValue = 0}) {
    if (json == null || !json.containsKey(key)) return defaultValue;
    var value = json[key];
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    if (value is String) {
      return int.tryParse(value) ??
          double.tryParse(value)?.toInt() ??
          defaultValue;
    }
    return defaultValue;
  }

  static double asDouble(Map<String, dynamic>? json, String key,
      {double defaultValue = 0.0}) {
    if (json == null || !json.containsKey(key)) return defaultValue;
    var value = json[key];
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is bool) return value ? 1.0 : 0.0;
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static bool asBool(Map<String, dynamic>? json, String key,
      {bool defaultValue = false}) {
    if (json == null || !json.containsKey(key)) return defaultValue;
    var value = json[key];
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is int) return value == 0 ? false : true;
    if (value is double) return value == 0 ? false : true;
    if (value is String) {
      if (value == "1" || value.toLowerCase() == "true") return true;
      if (value == "0" || value.toLowerCase() == "false") return false;
    }
    return defaultValue;
  }

  static String asString(Map<String, dynamic>? json, String key,
      {String defaultValue = ""}) {
    if (json == null || !json.containsKey(key)) return defaultValue;
    var value = json[key];
    if (value == null) return defaultValue;
    if (value is String) return value;
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is bool) return value ? "true" : "false";
    return defaultValue;
  }

  static Map<String, dynamic> asMap(Map<String, dynamic>? json, String key,
      {Map<String, dynamic>? defaultValue}) {
    if (json == null || !json.containsKey(key)) {
      return defaultValue ?? <String, dynamic>{};
    }
    var value = json[key];
    if (value == null) return defaultValue ?? <String, dynamic>{};
    if (value is Map<String, dynamic>) return value;
    return defaultValue ?? <String, dynamic>{};
  }

  static List asList(Map<String, dynamic>? json, String key,
      {List? defaultValue}) {
    if (json == null || !json.containsKey(key)) return defaultValue ?? [];
    var value = json[key];
    if (value == null) return defaultValue ?? [];
    if (value is List) return value;
    return defaultValue ?? [];
  }

//   static Future<MultipartFile?> fileToMultiPartFile(File? file) async {
//     String fileName = file!.path.split('/').last;
//     final multipartFile = await MultipartFile.fromFile(
//       file.path,
//       filename: fileName,
//     );
//     return multipartFile;
//   }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
