// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';
import 'package:learn_flutter_supabase/presentations/new_data/view/insert_data_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertDataController extends State<InsertDataView> {
  final nameField = TextEditingController();
  final ValueNotifier<bool> validForm = ValueNotifier<bool>(false);
  bool isAsync = false;

  @override
  void initState() {
    nameField.addListener(() {
      validForm.value = isFormValid();
    });
    super.initState();
  }

  final supabase = Supabase.instance.client;

  btnInsert() async {
    isAsync = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        await supabase
            .from('products')
            .insert({'name': nameField.text}).select();
        Alert(
            context: context,
            desc: 'data success',
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
            ]).show().then((value) => Go.to(const HomeView()));
      } on AuthException catch (e) {
        isAsync = false;
        setState(() {});
        return Alert(
            // ignore: use_build_context_synchronously
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

  bool isFormValid() => nameField.text.isNotEmpty;

  ValueListenableBuilder<T> listenableBuilder<T>(
      {required ValueNotifier<T> notifier,
      required Widget Function(BuildContext context, T value, Widget? widget)
          builder}) {
    return ValueListenableBuilder<T>(
        valueListenable: notifier, builder: builder);
  }

  ValueListenableBuilder<bool> saveButtonState(
      {required Widget Function(bool isEnabled) builder}) {
    return listenableBuilder<bool>(
      notifier: validForm,
      builder: (context, isEnabled, child) {
        return builder(isEnabled);
      },
    );
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
