// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';
import 'package:learn_flutter_supabase/presentations/update_data/view/update_data_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateDataController extends State<UpdateDataView> {
  final nameField = TextEditingController();
  final priceField = TextEditingController();
  final ValueNotifier<bool> validForm = ValueNotifier<bool>(false);
  bool isAsync = false;

  final supabse = Supabase.instance.client;

  void updateData() async {
    isAsync = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        await supabse.from('products').update({
          'name': nameField.text,
          'price': priceField.text,
        }).eq('id', widget.id);
        Alert(
            context: context,
            desc: 'update success',
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

  bool isFormValid() => nameField.text.isNotEmpty && priceField.text.isNotEmpty;

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
  void initState() {
    nameField.text = widget.name;
    priceField.text = widget.price.toString();
    nameField.addListener(() {
      validForm.value = isFormValid();
    });
    priceField.addListener(() {
      validForm.value = isFormValid();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
