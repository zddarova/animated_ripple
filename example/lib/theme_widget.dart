import 'package:flutter/material.dart';

class ThemeWidget extends InheritedWidget {
  ThemeWidget({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final ThemeState _state = ThemeState();

  void switchTheme() => _state.isLightModeActive = !_state.isLightModeActive;

  ThemeMode get theme => _state.isLightModeActive ? ThemeMode.light() : ThemeMode.dark();

  static ThemeWidget of(BuildContext context) {
    final ThemeWidget? result = context.dependOnInheritedWidgetOfExactType<ThemeWidget>();
    assert(result != null, 'No ThemeWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeWidget oldWidget) => true;
}

class ThemeState {
  bool isLightModeActive = true;
}

class ThemeMode {
  factory ThemeMode.light() => const ThemeMode(Colors.black, Colors.white);

  factory ThemeMode.dark() => const ThemeMode(Colors.white, Colors.black);

  final Color mainColor;

  final Color secondaryColor;

  const ThemeMode(this.mainColor, this.secondaryColor);
}
