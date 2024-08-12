import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';
import 'package:learn_flutter_supabase/presentations/home/controller/home_controller.dart';
import 'package:learn_flutter_supabase/presentations/new_data/view/insert_data_view.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

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
        endDrawer: Drawer(
            child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () => controller.btnLogout(),
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: CommonText(text: 'Logout'),
                ),
              ),
            ),
          ],
        )),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: FutureBuilder(
                future: controller.future,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
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
                          leading: product['photo_product'] == null
                              ? const SizedBox()
                              : Image.network(
                                  '${dotenv.env[IMG_PATH]}${product['photo_product']}?token=${dotenv.env[TOKEN]}',
                                  height: 50,
                                  width: 50,
                                ),
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
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Go.to(const InsertDataView()),
            child: const Icon(
              Icons.add,
              color: white,
            )),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => HomeController();
}
