import 'dart:io';

import 'package:flutter/services.dart';
import 'package:learn_flutter_supabase/core/component/toast.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';

dynamic currentTime;
Future<bool> willPop(context) async {
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
