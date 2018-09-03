import 'package:flutter/material.dart';

class DiscoucherTheme {
  final discoucherGreen900 = Colors.green[900];
  final discoucherRed700 = Colors.red[700];
  final discoucherPink100 = Color(0xFFC2185B);
  final discoucherPurple = Color(0xFFe040fb);
  final discoucherErrorRed = Color(0xFFC5032B);
  final discoucherSurfaceWhite = Color(0xFFFFFBFA);
  final discoucherBackgroundWhite = Colors.white;

  ThemeData get theme {
    return _buildDiscoucherTheme();
  }

  ThemeData _buildDiscoucherTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: discoucherRed700,
      primaryColor: discoucherGreen900,
      buttonColor: discoucherGreen900,
      scaffoldBackgroundColor: discoucherBackgroundWhite,
      cardColor: discoucherBackgroundWhite,
      textSelectionColor: discoucherPink100,
      errorColor: discoucherErrorRed,
      splashColor: discoucherPurple.withOpacity(0.5),

      // TODO: Add the text themes (103)
      // TODO: Add the icon themes (103)
      // TODO: Decorate the inputs (103)
    );
  }
}
