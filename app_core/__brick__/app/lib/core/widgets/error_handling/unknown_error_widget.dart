import 'package:flutter/material.dart';

import 'error_handling_widget.dart';

class UnknownErrorWidget extends StatelessWidget
    implements ErrorHandlingWidget {
  const UnknownErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
