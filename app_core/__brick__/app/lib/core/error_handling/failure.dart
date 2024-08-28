abstract class Failure {
  final int? errorCode;
  final String? message;

  Failure({this.errorCode, this.message});
}

class ServerErrorFailure extends Failure {
  ServerErrorFailure({super.errorCode, super.message});
}

class NoInternetConnectionFailure extends Failure {}

class UnknownFailure extends Failure {
  UnknownFailure({super.errorCode, super.message});
}

class SocketFailure extends Failure {
  SocketFailure({super.errorCode, super.message});
}

class BadRequestFailure extends Failure {
  BadRequestFailure({super.errorCode, super.message});
}

class CancelByUserFailure extends Failure {}

class TypeErrorFailure extends Failure {
  TypeErrorFailure({super.errorCode, super.message});
}

class RequireItemsFailure extends Failure {}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({super.errorCode, super.message});
}

class DataBaseFailure extends Failure {}
