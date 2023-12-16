import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.buildContext,
    this.controller,
    this.hintText,
    this.validator,
    this.brdrside,
    this.keybrdtype,
    this.fontFamily,
    this.isPasswordObscured,
    this.onTap,
    this.prefixIcon,
    this.maxLength,
    this.readOnly,
    this.onChange,
    this.enableInteractiveSelection,
    this.enabled,
    this.suffixIcon,
    this.isRequired,
    this.label,
    this.fontWeight,
    this.textFormatter,
    this.autoFocus,
    this.nextFocus,
    this.maxLines,
    this.onFieldSubmitted,
    this.labelColor,
    this.textInputAction,
    this.fillColor,
  });

  final FontWeight? fontWeight;
  final Color? fillColor;
  final bool? isPasswordObscured;
  final int? maxLength;
  final BuildContext? buildContext;
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final OutlineInputBorder? brdrside;
  final Function(String?)? onChange;
  final Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keybrdtype;
  final Widget? prefixIcon;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool? isRequired;
  final bool? readOnly;
  final Color? labelColor;
  final String? fontFamily;
  final List<TextInputFormatter>? textFormatter;
  final bool? enabled;
  final bool? enableInteractiveSelection;
  final FocusNode? autoFocus;
  final FocusNode? nextFocus;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            label == null
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : Text(
                    label!,
                    style: TextStyle(
                      color: labelColor,
                      fontSize: 15,
                      fontFamily: fontFamily,
                    ),
                  ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: autoFocus,
                inputFormatters: textFormatter,
                enabled: readOnly ?? true,
                readOnly: readOnly == null ? false : readOnly!,
                enableInteractiveSelection: enableInteractiveSelection ?? true,
                maxLength: maxLength,
                maxLines: maxLines ?? 1,
                keyboardType: keybrdtype,
                onTap: onTap,
                onChanged: onChange,
                controller: controller,
                textInputAction: textInputAction ?? TextInputAction.done,
                validator: validator,
                obscureText: isPasswordObscured ?? false,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.red[900],
                    fontWeight: fontWeight ?? FontWeight.normal,
                    // fontFamily: fontFamily ?? AppFonts.regular,
                    fontSize: 15,
                    wordSpacing: 3,
                  ),
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: brdrside,
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  fillColor: fillColor,
                  filled: fillColor != null ? true : false,
                  prefixIcon: prefixIcon,
                ),
                onFieldSubmitted: onFieldSubmitted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
