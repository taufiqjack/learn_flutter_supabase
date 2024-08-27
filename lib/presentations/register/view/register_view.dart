import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/register/controller/register_controller.dart';
import 'package:learn_flutter_supabase/presentations/signin/view/signin_view.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_button.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_password_field.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textfield.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  Widget build(BuildContext context, RegisterController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CommonText(
                text: 'Register',
                fontSize: 18,
                color: greyLightFive,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 30,
              ),
              CommonTextField(
                  controller: controller.emailField,
                  hintText: 'Email',
                  textInputType: TextInputType.text),
              const SizedBox(height: 10),
              CommonPasswordField(
                controller: controller.passwordField,
                filled: true,
                fillColor: whiteTwo,
                keyboardType: TextInputType.text,
                obsecure: true,
                showPassword: controller.showPassword,
                hintText: 'Password',
                onClickShowPassword: () => controller.toggleShowPassword(),
                action: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
              controller.saveButtonState(
                builder: (isEnabled) => CommonButton(
                  buttonText: 'Register',
                  isEnabled: isEnabled,
                  onTap: () => controller.btnRegister(),
                  size: Size(MediaQuery.of(context).size.width, 40),
                  buttonBackgroundColor: purple.withOpacity(0.8),
                  buttonTextColor: white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CommonText(text: 'Already have an account?'),
              InkWell(
                onTap: () {
                  Go.to(const SignInView());
                },
                child: const CommonText(
                  text: 'Sign In',
                  color: red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => RegisterController();
}
