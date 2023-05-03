import 'package:flutter/material.dart';
import 'package:hive_note/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.maxLine,
    this.hintText,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.border,
    this.suffixIcon,
    this.focusNode,
    this.autofocus = false,
  });

  final int? maxLine;
  final String? hintText;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final InputBorder? border;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        autofocus: autofocus,
        initialValue: initialValue,
        validator: (value) =>
            value?.isEmpty ?? true ? 'Field is required' : null,
        onSaved: onSaved,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          enabledBorder: border ?? buildBorder(),
          errorBorder: border ?? buildBorder(Colors.red),
          focusedBorder: border ?? buildBorder(kPrimaryColor),
          border: border ?? buildBorder(),
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
        maxLines: maxLine ?? 1,
      );

  OutlineInputBorder buildBorder([Color? color]) => OutlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.white),
        borderRadius: BorderRadius.circular(8),
      );
}
