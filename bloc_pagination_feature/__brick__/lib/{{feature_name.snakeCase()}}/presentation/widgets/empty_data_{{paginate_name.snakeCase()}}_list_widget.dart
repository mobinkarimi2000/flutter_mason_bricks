import 'package:flutter/material.dart';

class EmptyData{{paginate_name.pascalCase()}}ListWidget extends StatelessWidget {
  const EmptyData{{paginate_name.pascalCase()}}ListWidget({
    super.key,
    this.color,
    this.onClickListener,
    this.message = ' ',
  });
  final String message;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
