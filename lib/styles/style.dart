import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFC107);
  static const Color textColor = Colors.black;

  // Gradient background colors
  static const List<Color> gradientColors = [
    Color(0xFFE7BC2F),
    Color.fromARGB(255, 254, 233, 163),
    Color(0xFFFFF6DA),
    Color(0xFFFDF8EA),
  ];

  static const TextStyle appBarTitleStyle = TextStyle(
    color: textColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent, 
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: appBarTitleStyle,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      titleLarge: TextStyle(color: textColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppTheme.textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppTheme.textColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppTheme.textColor,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
}

class AppButtonStyles {
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.primaryColor,
    foregroundColor: AppTheme.textColor,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final ButtonStyle secondaryButton = OutlinedButton.styleFrom(
    foregroundColor: AppTheme.primaryColor,
    side: const BorderSide(color: AppTheme.primaryColor),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  static const EdgeInsets paddingAll = EdgeInsets.all(md);
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: md);
}
