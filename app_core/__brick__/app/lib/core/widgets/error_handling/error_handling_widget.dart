import 'package:flutter/material.dart';
import '../../error_handling/failure.dart';
import 'no_internet_connection_widget.dart';
import 'server_error_widget.dart';
import 'unauthorized_error_widget.dart';
import 'unknown_error_widget.dart';

abstract class ErrorHandlingWidget extends Widget {
  factory ErrorHandlingWidget(
    Failure failure, {
    final void Function()? onClickListener,
  }) {
    switch (failure) {
      case ServerErrorFailure():
        return ServerErrorWidget(onClickListener: onClickListener);
      case UnauthorizedFailure():
        return UnauthorizedErrorWidget(onClickListener: onClickListener);
      case NoInternetConnectionFailure():
        return NoInternetConnectionErrorWidget(
            onClickListener: onClickListener);
      // case UnknownFailure(errorCode: e.errorCode,message: e.errorMessage): return UnknownErrorWidget(onClickListener: onClickListener);
      default:
        return const UnknownErrorWidget();
    }
  }
}
