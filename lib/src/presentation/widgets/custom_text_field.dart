// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/core.dart';
import '../shared/animated_size_wrapper.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final IconData? prefixIcon;
  final Function(String)? onChanged;
  final String? errorText;
  final int? maxLength;
  final TextInputType keyboardType;
  final FloatingLabelBehavior floatingLabelBehavior;
  final EdgeInsets? paddingIcon;
  final bool isDense;
  final String? currentValue;
  final bool isShowHintText;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Function(String)? onSubmitted;
  final Function()? onTap;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.prefixIcon,
    this.onChanged,
    this.errorText,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.paddingIcon,
    this.isDense = false,
    this.currentValue,
    this.isShowHintText = true,
    this.inputFormatters,
    this.maxLines = 1,
    this.readOnly = false,
    this.suffixIcon,
    this.controller,
    this.textInputAction,
    this.obscureText = false,
    this.onSubmitted,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSizeWrapper(
      child: Column(
        children: [
          TextFormField(
            onTap: widget.onTap,
            onFieldSubmitted: widget.onSubmitted,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: (_) {
              widget.onChanged;
              setState(() {});
            },
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            controller: widget.controller,
            initialValue:
                widget.controller == null ? widget.currentValue : null,
            style: kTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  width: .1,
                  color: kTheme.colorScheme.primary.withOpacity(0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: kTheme.colorScheme.primary,
                ),
              ),
              hintText: widget.isShowHintText ? widget.labelText : null,
              hintStyle: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.onBackground,
              ),
              labelStyle: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.onBackground.withOpacity(0.5),
              ),
              filled: true,
              fillColor: kTheme.colorScheme.primaryContainer.withOpacity(.3),
              isDense: widget.isDense,
              prefixIcon: widget.prefixIcon != null && widget.maxLines == 1
                  ? Icon(
                      widget.prefixIcon,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 36),
              suffixIcon: widget.suffixIcon != null && widget.maxLines == 1
                  ? widget.suffixIcon
                  : null,
              suffixIconConstraints: const BoxConstraints(minWidth: 36),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
            ),
          ),
          if (widget.errorText != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.errorText!,
                  style: kTheme.textTheme.bodyMedium?.copyWith(
                    color: kTheme.colorScheme.error,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
