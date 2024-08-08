import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/presentations/home/controller/home_controller.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  Widget build(BuildContext context, HomeController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text('Outdoor Catalogs'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: FutureBuilder(
              future: controller.future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var products = snapshot.data;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          '${index + 1}. ${product['name']}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    );
                  },
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
            onPressed: () => controller.btnLogout(),
            child: const Icon(
              Icons.logout,
              color: white,
            )),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => HomeController();
}
