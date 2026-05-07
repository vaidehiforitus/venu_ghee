import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? lineHeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? letterSpacing;
  final String? fontFamily;
  final bool? softWrap;

  const TextWidget({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.lineHeight,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.fontFamily,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      style: TextStyle(
        color: color ?? ColorConstants.textColor,
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: lineHeight,
        decoration: decoration,
        decorationColor: decorationColor,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
      ),
    );
  }
}