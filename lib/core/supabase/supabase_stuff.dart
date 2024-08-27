import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInit {
  static Future<void> init() async {
    await Supabase.initialize(
        url: '${dotenv.env[BASE_URL]}', anonKey: '${dotenv.env[ANON_KEY]}');
  }
}
