import 'package:animated_ripple/animated_ripple.dart';
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
        backgroundColor: Colors.white,
        title: const Text(
          'Animated Ripple Example App',
          style: TextStyle(color: Colors.black),
        ),
      ),
      // todo (andreyK): add Inherited widget to set this props
      body: const Center(
        child: AnimatedRipple(
          size: Size.fromRadius(300),
          numberOfRipples: 10,
          duration: Duration(seconds: 2),
          color: Colors.black,
          loopAnimation: true,
        ),
      ),
    );
  }
}
