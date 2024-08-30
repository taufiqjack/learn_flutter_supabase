import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/models/message_model.dart';
import 'package:learn_flutter_supabase/core/models/user_model.dart';
import 'package:learn_flutter_supabase/presentations/chat/view/chat_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends State<ChatView> {
  final supabase = Supabase.instance.client;
  late final Stream<List<Message>> messagesStream;
  final Map<String, Profile> profileCache = {};

  @override
  void initState() {
    final myUserId = supabase.auth.currentUser!.id;
    messagesStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromMap(map: map, myUserId: myUserId))
            .toList());
    super.initState();
  }

  Future<void> loadProfileCache(String profileId) async {
    if (profileCache[profileId] != null) {
      return;
    }
    final data =
        await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profile.fromMap(data);
    setState(() {
      profileCache[profileId] = profile;
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
