import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/component/container.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/presentations/catalog/view/catalog_view.dart';
import 'package:learn_flutter_supabase/presentations/chat/view/chat_view.dart';
import 'package:learn_flutter_supabase/presentations/home/controller/home_controller.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  Widget build(BuildContext context, HomeController controller) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          title: const CommonText(text: 'Supabase'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
          onWillPop: controller.willPop,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => Go.to(const CatalogView()),
                child: Container(
                  height: MediaQuery.of(context).size.width / 5,
                  width: MediaQuery.of(context).size.width / 5,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: red),
                  child: const Center(
                    child: CommonText(
                      text: 'catalog',
                      color: white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Go.to(const ChatView()),
                child: Container(
                  height: MediaQuery.of(context).size.width / 5,
                  width: MediaQuery.of(context).size.width / 5,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: red),
                  child: const Center(
                    child: CommonText(
                      text: 'chat',
                      color: white,
                    ),
                  ),
                ),
              ),
            ],
          ).paddedLTRB(top: 50, right: 16, left: 16)),
        ));
  }

  @override
  State<StatefulWidget> createState() => HomeController();
}
