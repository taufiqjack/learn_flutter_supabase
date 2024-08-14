import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/presentations/update_data/controller/update_data_controller.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_button.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textfield.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class UpdateDataView extends StatefulWidget {
  final dynamic id;
  final String name;
  final String? price;
  const UpdateDataView({
    super.key,
    this.id,
    required this.name,
    this.price,
  });

  Widget build(BuildContext context, UpdateDataController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(color: black),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonText(
                text: 'Edit Product',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                controller: controller.nameField,
                hintText: 'name',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                controller: controller.priceField,
                hintText: 'price',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              controller.saveButtonState(
                builder: (isEnabled) => CommonButton(
                  buttonText: 'Save',
                  isEnabled: isEnabled,
                  onTap: () => controller.updateData(),
                  buttonBackgroundColor: purpleTwo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => UpdateDataController();
}
