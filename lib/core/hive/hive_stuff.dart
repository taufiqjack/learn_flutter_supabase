import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';
import 'package:path_provider/path_provider.dart';

import 'hive_const.dart';

class HiveStuff {
  static Future<void> init() async {
    if (!kIsWeb) {
      var path = await getTemporaryDirectory();
      Hive.init(path.path);
    }

    LOGGEDBOX = await Hive.openBox(LOGGED);
  }
}
