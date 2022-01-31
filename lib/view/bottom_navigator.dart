import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mess_record_app/model/database.dart';
import 'package:mess_record_app/view/app_settings/settings_widget.dart';
import 'dashboard/dashboard.dart';

import 'profile_settings/settings_page.dart';

class MyAppBottomNavigationBar extends StatefulWidget {
  const MyAppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyAppBottomNavigationBarState createState() =>
      _MyAppBottomNavigationBarState();
}

class _MyAppBottomNavigationBarState extends State<MyAppBottomNavigationBar> {
  late List<StatefulWidget> widgetList;

  _MyAppBottomNavigationBarState() {
    initState();
  }

  @override
  void initState() {
    super.initState();
    widgetList = [Dashboard(), SettingsPage(), const SettingsWidget()];
    if (Database.loaded) {
      _selectedIndex = 0;
    }

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Dashboard(),
        ),
        (route) => route.isFirst,
      );
    });
  }

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            // label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            // label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: '',
            // label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // selectedIconTheme: Theme.of(context).iconTheme,
        // unselectedIconTheme: Theme.of(context).iconTheme,
      ),
    );
  }

  @override
  void dispose() {
    Database.dispose();
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }
}
