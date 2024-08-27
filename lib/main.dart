import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_flutter_supabase/core/hive/hive_const.dart';
import 'package:learn_flutter_supabase/core/hive/hive_stuff.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/core/supabase/supabase_stuff.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';
import 'package:learn_flutter_supabase/presentations/signin/view/signin_view.dart';

import 'core/utils/const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ENV_PATH);
  await SupabaseInit.init();
  await HiveStuff.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 151, 84, 228)),
          colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 151, 84, 228))),
      home:
          LOGGEDBOX.get(LOGGED) == true ? const HomeView() : const SignInView(),
      navigatorKey: Go.navigatorKey,
    );
  }
}
