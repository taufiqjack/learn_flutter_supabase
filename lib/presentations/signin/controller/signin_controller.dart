import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/hive/hive_const.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';
import 'package:learn_flutter_supabase/presentations/signin/view/signin_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInController extends State<SignInView> {
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  bool isAsync = false;
  final ValueNotifier<bool> validForm = ValueNotifier<bool>(false);

  bool showPassword = true;

  void toggleShowPassword() {
    showPassword = !showPassword;
    setState(() {});
  }

  btnSignIn() async {
    isAsync = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        await Supabase.instance.client.auth.signInWithPassword(
            email: emailField.text, password: passwordField.text);
        LOGGEDBOX.put(LOGGED, true);
        Go.to(const HomeView());
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
/* 
    Future.delayed(const Duration(seconds: 3), () {
      isAsync = false;
      setState(() {});
      Alert(
          context: context,
          desc: 'error',
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
    }); */
  }

  @override
  void initState() {
    emailField.addListener(() {
      validForm.value = isFormValid();
    });
    passwordField.addListener(() {
      validForm.value = isFormValid();
    });
    super.initState();
  }

  bool isFormValid() =>
      emailField.text.isNotEmpty && passwordField.text.isNotEmpty;

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
