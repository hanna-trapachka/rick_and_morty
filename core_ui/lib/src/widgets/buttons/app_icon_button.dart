import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.child,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.splashColor,
    this.size = 48,
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? splashColor;
  final double size;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(100),
        splashColor: splashColor,
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: backgroundColor,
          ),
          child: Center(child: child),
        ),
      );
}
