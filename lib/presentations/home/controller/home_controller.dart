import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_flutter_supabase/core/component/toast.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';

class HomeController extends State<HomeView> {
  dynamic currentTime;
  Future<bool> willPop() async {
    DateTime now = DateTime.now();

    if (currentTime == null ||
        now.difference(currentTime!) > const Duration(seconds: 2)) {
      currentTime = now;
      toast(context, exit_message);
      return Future.value(false);
    }
    SystemNavigator.pop();
    exit(0);
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
