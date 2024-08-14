import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/new_data/controller/insert_data_controller.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_button.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textfield.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class InsertDataView extends StatefulWidget {
  const InsertDataView({super.key});

  Widget build(BuildContext context, InsertDataController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Go.back(),
            icon: const Icon(Icons.arrow_back_outlined),
            color: black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonText(
                text: 'Add Data',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                  controller: controller.nameField,
                  hintText: 'Name',
                  capitalization: TextCapitalization.words,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                  controller: controller.priceField,
                  hintText: 'Price',
                  capitalization: TextCapitalization.words,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 15,
              ),
              controller.saveButtonState(
                builder: (isEnabled) => CommonButton(
                  buttonText: 'Submit',
                  isEnabled: isEnabled,
                  onTap: () => controller.btnInsert(),
                  size: Size(MediaQuery.of(context).size.width, 40),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => InsertDataController();
}
