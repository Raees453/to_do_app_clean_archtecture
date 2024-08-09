import 'package:flutter/material.dart';

extension BuildExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Color get color => theme.colorScheme.primary;

  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;
}
