import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.backgroundColor,
    this.surfaceTintColor,
    this.elevation = 5,
    this.onTap,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 10,
  });
  final Color backgroundColor;
  final Color? surfaceTintColor;
  final double elevation;
  final Function()? onTap;
  final Widget child;
  final double? height;
  final double? width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          foregroundColor: surfaceTintColor,
          minimumSize: Size(this.width ?? width, height ?? 50),
          elevation: elevation,
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor),
      onPressed: onTap != null
          ? () {
              if (onTap != null) {
                onTap!();
              }
            }
          : null,
      child: child,
    );
  }
}
