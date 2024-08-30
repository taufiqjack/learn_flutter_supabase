// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/hive/hive_const.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/catalog/view/catalog_view.dart';
import 'package:learn_flutter_supabase/presentations/signin/view/signin_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CatalogController extends State<CatalogView> {
  final future = Supabase.instance.client.from('products').select();
  bool isAsync = false;
  final supabase = Supabase.instance.client;

  btnLogout() async {
    isAsync = true;
    setState(() {});
    await supabase.auth.signOut();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        LOGGEDBOX.clear();
        Go.to(const SignInView());
      },
    );
  }

  void deleteById(int id) async {
    isAsync = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        await supabase.from('products').delete().eq('id', id);
        Alert(
            context: context,
            desc: 'data delete',
            style: const AlertStyle(
                descPadding: EdgeInsets.only(top: 10),
                descStyle: TextStyle(color: greySix)),
            type: AlertType.success,
            buttons: [
              DialogButton(
                color: greenTwo,
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: greySix,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () => Go.back(),
              )
            ]).show().then((value) => Go.to(const CatalogView()));
      } on AuthException catch (e) {
        isAsync = false;
        setState(() {});
        return Alert(
            context: context,
            desc: e.message,
            style: AlertStyle(
                descPadding: const EdgeInsets.only(top: 10),
                descStyle: TextStyle(color: red.withOpacity(0.7))),
            type: AlertType.error,
            buttons: [
              DialogButton(
                color: greyThree,
                child: const Text(
                  'OK',
                  style: TextStyle(color: white, fontSize: 16),
                ),
                onPressed: () => Go.back(),
              )
            ]).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
