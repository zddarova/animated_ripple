import 'package:animated_ripple/animated_ripple.dart';
import 'package:example/settings_screen.dart';
import 'package:example/theme_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeWidget.of(context).theme.secondaryColor,
        title: Text(
          'Animated Ripple Example App',
          style: TextStyle(
            color: ThemeWidget.of(context).theme.mainColor,
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: ThemeWidget.of(context).theme.secondaryColor),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                // todo (andreyK): figure out what is happening with sized and opacities
                child: AnimatedRipple(
                  size: const Size.fromRadius(300),
                  numberOfRipples: 7,
                  duration: const Duration(seconds: 1),
                  color: ThemeWidget.of(context).theme.mainColor,
                  secondaryColor: ThemeWidget.of(context).theme.secondaryColor,
                  rippleEffect: RippleEffect.speedUpOnTap,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CupertinoButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => const SettingsScreen(), fullscreenDialog: true),
                    );
                    setState(() {});
                  },
                  child: Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, color: ThemeWidget.of(context).theme.mainColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
