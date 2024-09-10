import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/routes/route_constants.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';
import 'package:learn_flutter_supabase/presentations/catalog/controller/catalog_controller.dart';
import 'package:learn_flutter_supabase/presentations/new_data/view/insert_data_view.dart';
import 'package:learn_flutter_supabase/presentations/update_data/view/update_data_view.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_circular_progress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_modal_porgress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  Widget build(BuildContext context, CatalogController controller) {
    return ModalProgress(
      inAsyncCall: controller.isAsync,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: purpleTwo),
          title: const CommonText(
            text: 'Outdoor Catalogs',
            color: purpleTwo,
          ),
          centerTitle: true,
          backgroundColor: white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
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
        body: FutureBuilder(
          future: controller.future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: CommonCircularProgress());
            }

            var products = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products?.length,
                  itemBuilder: (context, index) {
                    final product = products?[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, bottom: 10),
                      child: Slidable(
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              controller.deleteById(
                                  int.parse(product!['id'].toString()));
                            },
                            label: 'delete',
                            backgroundColor: red,
                            icon: Icons.delete,
                          )
                        ]),
                        child: Card(
                          elevation: 0.5,
                          child: InkWell(
                            onTap: () => Go.to(UpdateDataView(
                              id: product?['id'].toString(),
                              name: product?['name'],
                              price: product?['price'],
                            )),
                            child: ListTile(
                              leading: product?['photo_product'] == null
                                  ? const SizedBox()
                                  : Image.network(
                                      '${dotenv.env[IMG_PATH]}${product?['photo_product']}?token=${dotenv.env[TOKEN]}',
                                      height: 50,
                                      width: 50,
                                    ),
                              title: CommonText(
                                  text: '${index + 1}. ${product?['name']}',
                                  fontWeight: FontWeight.w700),
                              subtitle: CommonText(
                                  text: 'IDR ${product?['price'] ?? '-'}'),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
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
  State<StatefulWidget> createState() => CatalogController();
}
