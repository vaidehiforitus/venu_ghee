import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venu_ghee/core/constants/color_constants.dart';
import 'package:venu_ghee/core/theme/theme_helper.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final bool enablePasswordToggle;
  final bool readOnly;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? initialValue;

  const TextFormFieldWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.fillColor,
    this.enablePasswordToggle = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.contentPadding,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.labelColor,
    this.hintColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.focusNode,
    this.autofocus = false,
    this.initialValue,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.enablePasswordToggle;

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: isPassword ? _obscureText : false,
      inputFormatters: widget.inputFormatters,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      initialValue: widget.initialValue,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: TextStyle(
        fontSize: widget.fontSize ?? 14.sp,
        fontWeight: widget.fontWeight ?? FontWeight.w400,
        color: widget.textColor ?? ThemeHelper.textColor(),
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: widget.fillColor ?? ThemeHelper.textColor(),
        counterText: '',
        labelStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: widget.labelColor ?? ThemeHelper.textColor(),
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: widget.hintColor ?? ColorConstants.lightTextColor,
        ),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        prefixIcon: widget.prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: ColorConstants.lightTextColor,
            size: 14.sp,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.r),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.r),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.r),
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? ColorConstants.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}