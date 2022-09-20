import 'package:example/home_screen.dart';
import 'package:flutter/material.dart';

class AnimatedRippleExampleApp extends StatelessWidget {
  const AnimatedRippleExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
