import 'package:flutter/material.dart';
import 'package:mess_record_app/view/app_settings/app_theme.dart';
import 'package:mess_record_app/view/constants.dart';
import 'package:provider/provider.dart';

class ChangeThemeSwitchWidget extends StatelessWidget {
  const ChangeThemeSwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
      activeColor: Constants.primaryColor,
      activeTrackColor: Constants.primaryColor.shade200,
    );
  }
}
