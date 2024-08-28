class ValueValidators {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Enter your email';
    }
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (RegExp(emailRegex).hasMatch(value)) {
      return null;
    }
    return 'please enter a correct value';
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Enter your a value';
    }
    if (value.length < 8) {
      return 'short password';
    }
    return null;
  }

  static String? phoneNumberValidator({
    String? value,
    required String wrongValue,
    required String emptyValue,
    required int numberOfCharacters,
  }) {
    if (value!.isEmpty) {
      return emptyValue;
    }
    if (value.length <= numberOfCharacters) {
      return wrongValue;
    }
    return null;
  }
}
