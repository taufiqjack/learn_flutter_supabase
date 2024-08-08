import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/register/view/register_view.dart';
import 'package:learn_flutter_supabase/presentations/signin/controller/signin_controller.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_button.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_password_field.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textfield.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  Widget build(BuildContext context, SignInController controller) {
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
                  text: 'Login',
                  fontSize: 18,
                  color: greyLightFive,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonTextField(
                  controller: controller.emailField,
                  hintText: 'email',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonPasswordField(
                  controller: controller.passwordField,
                  filled: true,
                  fillColor: whiteTwo,
                  keyboardType: TextInputType.text,
                  obsecure: true,
                  showPassword: controller.showPassword,
                  hintText: 'password',
                  onClickShowPassword: () => controller.toggleShowPassword(),
                  action: TextInputAction.done,
                ),
                const SizedBox(
                  height: 12,
                ),
                controller.saveButtonState(
                  builder: (isEnabled) => CommonButton(
                    buttonText: 'Masuk',
                    isEnabled: isEnabled,
                    onTap: () => controller.btnSignIn(),
                    size: Size(MediaQuery.of(context).size.width, 40),
                    buttonBackgroundColor: purple.withOpacity(0.8),
                    buttonTextColor: white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CommonText(text: 'belum memiliki akun?'),
                InkWell(
                  onTap: () {
                    Go.to(const RegisterView());
                  },
                  child: const CommonText(
                    text: 'Register',
                    color: red,
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => SignInController();
}
