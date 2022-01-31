import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mess_record_app/model/database.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    // appBarTheme: AppBarTheme(color: Colors.black54),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black54,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(
        // primary: Colors.purple,
        ),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.grey.shade700, foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(10.0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade700),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
    ),
  );

  static final lightTheme = ThemeData(
    // appBarTheme: AppBarTheme(color: Colors.white24),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.purple.shade900,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
        // primary: Colors.green,
        ),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.deepPurple, opacity: 0.8),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white, foregroundColor: Colors.grey),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10.0)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey.shade400),
      thumbColor: MaterialStateProperty.all<Color>(Colors.grey),
      overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode =
      Database.isDarkTheme() != false ? ThemeMode.dark : ThemeMode.light;
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    Database.saveThemeMode(isOn);
    notifyListeners();
  }
}
