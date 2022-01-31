import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mess_record_app/app_life_cycle_manager.dart';
import 'package:mess_record_app/view/app_settings/app_theme.dart';
import 'package:mess_record_app/view/constants.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'model/attendance/attendance_manager.dart';
import 'model/database.dart';
import 'view/bottom_navigator.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Database.init();
  AttendanceManager.init();
  AwesomeNotifications().initialize(
    'resource://drawable/logo',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
      ),
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Hazri',
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: SplashScreenView(
              navigateRoute: const AppLifeCycleManager(
                child: const MyAppBottomNavigationBar(),
              ),
              duration: 100,
              imageSize: 500,
              imageSrc: 'logo/logo.png',
              text: Constants.appName,
              textType: TextType.NormalText,
              backgroundColor: themeProvider.isDarkMode
                  ? Colors.grey.shade900
                  : Colors.deepPurple,
              textStyle: const TextStyle(color: Colors.white, fontSize: 30.0),
              // colors: const [
              //   Constants.primaryColor,
              //   Constants.primaryColor,
              //   Constants.primaryColor,
              //   Constants.primaryColor
              // ],
              // backgroundColor: Constants.primaryColor,
            ),
          );
        });
  }
}
