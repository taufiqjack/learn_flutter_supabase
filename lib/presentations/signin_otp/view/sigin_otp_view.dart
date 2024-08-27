import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/signin/view/signin_view.dart';
import 'package:learn_flutter_supabase/presentations/signin_otp/controller/signin_otp_controller.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_button.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textfield.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class SigninOtpView extends StatefulWidget {
  const SigninOtpView({super.key});

  Widget build(BuildContext context, SiginOtpController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: white,
        ),
        body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonText(
                  text: 'Sign In with OTP',
                  fontSize: 18,
                  color: greyLightFive,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonTextField(
                  prefixLabel: '+62',
                  maxLength: 12,
                  controller: controller.phoneField,
                  hintText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 12,
                ),
                controller.saveButtonState(
                  builder: (isEnabled) => CommonButton(
                    buttonText: 'Sign In',
                    isEnabled: isEnabled,
                    onTap: () => controller.btnSignInWA(),
                    size: Size(MediaQuery.of(context).size.width, 40),
                    buttonBackgroundColor: purple.withOpacity(0.8),
                    buttonTextColor: white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CommonText(text: 'or'),
                InkWell(
                  onTap: () {
                    Go.to(const SignInView());
                  },
                  child: const CommonText(
                    text: 'Login with Email',
                    color: red,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => SiginOtpController();
}
