import 'package:flutter/material.dart';

BuildContext? get globalContext {
  return Go.navigatorKey.currentContext;
}

class Go {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static get currentContext {
    return navigatorKey.currentContext;
  }

  static to(Widget page) async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static back() {
    Navigator.pop(globalContext!);
  }

  static backThem(then) {
    Navigator.of(globalContext!).pop(then);
  }

  static close() {
    Navigator.of(globalContext!).pop(true);
  }

  static offAll(page) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  static toReplacement(page) {
    navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static popPush(page) {
    navigatorKey.currentState!.popAndPushNamed(page);
  }

  static double get width {
    return MediaQuery.of(currentContext).size.width;
  }

  static double get height {
    return MediaQuery.of(currentContext).size.width;
  }
}
