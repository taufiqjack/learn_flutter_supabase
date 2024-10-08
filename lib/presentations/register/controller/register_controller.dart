// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/register/view/register_view.dart';
import 'package:learn_flutter_supabase/presentations/signin/view/signin_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends State<RegisterView> {
  final usernameField = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final ValueNotifier<bool> validForm = ValueNotifier<bool>(false);
  bool showPassword = true;
  bool isAsync = false;

  void toggleShowPassword() {
    showPassword = !showPassword;
    setState(() {});
  }

  final supabase = Supabase.instance.client;

  btnRegister() async {
    isAsync = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        final AuthResponse res = await supabase.auth.signUp(
            email: emailField.text,
            password: passwordField.text,
            data: {'username': usernameField.text});

        res.user != null
            ? Go.to(const SignInView())
            : Alert(
                context: context,
                desc: 'User already registered',
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
