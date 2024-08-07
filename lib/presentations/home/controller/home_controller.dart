import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/presentations/home/view/home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends State<HomeView> {
  final future = Supabase.instance.client.from('products').select();
  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
