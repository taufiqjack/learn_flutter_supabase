import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/hive/hive_const.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';
import 'package:learn_flutter_supabase/presentations/signin/view/signin_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends State<HomeView> {
  final future = Supabase.instance.client.from('products').select();
  bool isAsync = false;

  btnLogout() async {
    isAsync = true;
    setState(() {});
    await Supabase.instance.client.auth.signOut();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        LOGGEDBOX.clear();
        Go.to(const SignInView());
      },
    );
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
