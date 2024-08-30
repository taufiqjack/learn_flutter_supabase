import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/utils/const.dart';
import 'package:learn_flutter_supabase/presentations/chat/view/message_bar_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageBarController extends State<MessageBarView> {
  final supabase = Supabase.instance.client;
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void submitMessage() async {
    final text = textController.text;
    final myUserId = supabase.auth.currentUser!.id;
    if (text.isEmpty) {
      return;
    }
    textController.clear();
    try {
      await supabase.from('messages').insert({
        'profile_id': myUserId,
        'content': text,
      });
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
