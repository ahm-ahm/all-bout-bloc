
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final RoundedRectangleBorder shape;
  final Color? borderColor;
  final VoidCallback onClick;
  final Color backgroundColor;
  final Widget text;

  const AppButton(
      {super.key, required this.text,
        required this.shape,
        required this.onClick,
        required this.backgroundColor,
        this.borderColor});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        constraints: const BoxConstraints(maxHeight: 44),
        onPressed: onClick,
        shape: shape,
        padding: const EdgeInsets.all(0),
        child: Ink(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: shape.borderRadius,
              border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null),
          child: Align(child: text),
        ));
  }
}