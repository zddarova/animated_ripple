import 'package:example/home_screen.dart';
import 'package:example/theme_widget.dart';
import 'package:flutter/material.dart';

class AnimatedRippleExampleApp extends StatelessWidget {
  const AnimatedRippleExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}
