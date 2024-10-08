import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/signin_otp/view/otp_verification_view.dart';
import 'package:learn_flutter_supabase/presentations/signin_otp/view/sigin_otp_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SiginOtpController extends State<SigninOtpView> {
  final phoneField = TextEditingController();
  bool isAsync = false;
  final ValueNotifier<bool> validForm = ValueNotifier<bool>(false);

  btnSignInWA() async {
    isAsync = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        await Supabase.instance.client.auth
            .signInWithOtp(phone: '+62${phoneField.text}');
        Go.to(OtpVerificationView(phoneNumber: phoneField.text));
        isAsync = false;
        setState(() {});
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

  @override
  void initState() {
    phoneField.addListener(() {
      validForm.value = isFormValid();
    });
    super.initState();
  }

  bool isFormValid() => phoneField.text.isNotEmpty;

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
