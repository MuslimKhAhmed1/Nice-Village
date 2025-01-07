import 'package:flutter/material.dart';

// class ThemeProvider with ChangeNotifier {
//   bool _isDarkMode = false;
//   bool get isDarkMode => _isDarkMode;

//   ThemeData get theme => _isDarkMode ? _darkTheme : _lightTheme;

//   static final ThemeData _lightTheme = ThemeData(
//     primaryColor: const Color(0xFFDEA30D),
//     secondaryHeaderColor: const Color(0xFF0D2F6B),
//     cardColor: Color(0xFFC4C4C4),
//     appBarTheme: AppBarTheme(
//       backgroundColor: const Color(0xFFD9D9D9),
//     ),
//     scaffoldBackgroundColor: const Color(0xFFF5F5F5),
//     textTheme: const TextTheme(
//       headlineLarge: TextStyle(color: Colors.black87),
//       bodyLarge: TextStyle(color: Colors.black87),
//     ),
//   );

//   static final ThemeData _darkTheme = ThemeData(
//     primaryColor: const Color(0xFFDEA30D),
//     secondaryHeaderColor: const Color(0xFF0D2F6B),
//     appBarTheme: AppBarTheme(
//       backgroundColor: const Color(0xFFD9D9D9),
//       titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     ),
//     scaffoldBackgroundColor: const Color(0xFF1E1E1E),
//     textTheme: const TextTheme(
//       headlineLarge: TextStyle(color: Colors.white),
//       bodyLarge: TextStyle(color: Colors.white70),
//     ),
//   );

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeData get theme => _isDarkMode ? _darkTheme : _lightTheme;

  static final ThemeData _lightTheme = ThemeData(
    primaryColor: const Color(0xFFDEA30D),
    secondaryHeaderColor: const Color(0xFF0D2F6B),
    cardColor: const Color(0xFFC4C4C4),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFD9D9D9),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[100],
      filled: true,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    primaryColor: const Color(0xFFDEA30D),
    secondaryHeaderColor: const Color(0xFF0D2F6B),
    cardColor: Colors.grey[800],
    hintColor: Colors.white,
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Colors.grey[600],
      titleTextStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    listTileTheme: ListTileThemeData(textColor: Colors.white),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[800],
      filled: true,
      hintStyle: const TextStyle(color: Colors.white70),
      labelStyle: const TextStyle(color: Colors.white70),
    ),
  );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
