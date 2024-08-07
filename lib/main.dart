import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_flutter_supabase/core/supabase/supabase_stuff.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';

import 'core/utils/const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ENV_PATH);
  await SupabaseInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 151, 84, 228))),
      home: const HomeView(),
    );
  }
}
