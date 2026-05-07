import 'package:flutter/material.dart';

extension SpaceXY on double {
  SizedBox get width => SizedBox(width: this); // For horizontal space
  SizedBox get height => SizedBox(height: this); // For vertical space
}
