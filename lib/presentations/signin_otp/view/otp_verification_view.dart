import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/signin_otp/controller/otp_verification_controller.dart';
import 'package:learn_flutter_supabase/presentations/signin_otp/view/sigin_otp_view.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_button.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationView extends StatefulWidget {
  final String phoneNumber;
  const OtpVerificationView({
    super.key,
    required this.phoneNumber,
  });

  Widget build(BuildContext context, OtpVerificationController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'OTP verification',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                    child: CommonText(
                      text:
                          '${'we have sent a verification code to'} ${'+62$phoneNumber'} ',
                      color: greyTwo,
                    ),
                  ),
                  WidgetSpan(
                      child: InkWell(
                    onTap: () => Go.to(
                      const SigninOtpView(),
                    ),
                    child: const CommonText(
                      text: 'change?',
                      color: red,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
                ])),
                const SizedBox(height: 50),
                const SizedBox(height: 20),
                PinCodeTextField(
                  autoDisposeControllers: false,
                  controller: controller.otpField,
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 6,
                  pinTheme: PinTheme(
                      fieldHeight: 40,
                      fieldWidth: 50,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      inactiveColor: grey,
                      activeFillColor: whiteTwo,
                      inactiveFillColor: white,
                      errorBorderColor: red,
                      activeColor: greenTwo),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
          child: controller.saveButtonState(
            builder: (isEnabled) => CommonButton(
              isEnabled: isEnabled,
              buttonText: 'Sign in',
              onTap: () => controller.btnOtpVerification(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => OtpVerificationController();
}
