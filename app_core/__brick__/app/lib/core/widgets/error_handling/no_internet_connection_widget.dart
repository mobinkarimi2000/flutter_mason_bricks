import 'package:flutter/material.dart';
import 'error_handling_widget.dart';

class NoInternetConnectionErrorWidget extends StatelessWidget
    implements ErrorHandlingWidget {
  const NoInternetConnectionErrorWidget(
      {super.key, this.color, this.onClickListener});
  final Color? color;
  final void Function()? onClickListener;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClickListener != null) {
          onClickListener!();
        }
      },
      child: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4),
        ],
      )),
    );
  }
}
