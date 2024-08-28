class RestApiException implements Exception {
  final int? errorCode;
  final String? errorMessage;
  RestApiException(this.errorCode, this.errorMessage);
}

class BadRequestException implements Exception {
  final int? errorCode;
  final String? errorMessage;
  BadRequestException({this.errorCode, this.errorMessage});
}

class CancelByUserException implements Exception {
  final int? errorCode;
  final String? errorMessage;
  CancelByUserException({this.errorCode, this.errorMessage});
}

class UnknownException implements Exception {
  final int? errorCode;
  final String? errorMessage;
  UnknownException({this.errorCode, this.errorMessage});
}

class ThirdPartyLoginException implements Exception {}

class NoInternetConnectionException implements Exception {
  NoInternetConnectionException();
}
