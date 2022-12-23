import 'package:example/theme_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLightTheme = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: ThemeWidget.of(context).theme.mainColor),
        ),
        leading: CloseButton(
          color: ThemeWidget.of(context).theme.mainColor,
        ),
        backgroundColor: ThemeWidget.of(context).theme.secondaryColor,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: ThemeWidget.of(context).theme.secondaryColor),
        child: Column(
          children: [
            Switch(
              value: isLightTheme,
              onChanged: (_) {
                setState(() {
                  isLightTheme = !isLightTheme;
                  ThemeWidget.of(context).switchTheme();
                });
              },
            ),
            Center(
              child: ClipOval(
                child: Container(
                  height: 100,
                  width: 100,
                  color: ThemeWidget.of(context).theme.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
