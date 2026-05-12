import 'package:flutter/material.dart';

double adaptiveFont(BuildContext context, double size) {
  final width = MediaQuery.of(context).size.width;

  // mobile
  if (width < 600) {
    return size;
  }

  // tablet
  if (width < 1024) {
    return size * 0.88;
  }

  // desktop/web
  return size * 0.78;
}
//
// double adaptiveFont(BuildContext context, double size) {
//   final w = MediaQuery.of(context).size.width;
//   if (w < 600) return size;
//   if (w < 1024) return size * 0.90;
//   return size * 0.80;
// }