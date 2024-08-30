import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/models/message_model.dart';
import 'package:learn_flutter_supabase/presentations/chat/controller/chat_controller.dart';
import 'package:learn_flutter_supabase/presentations/chat/view/bubble_chat.dart';
import 'package:learn_flutter_supabase/presentations/chat/view/message_bar_view.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_circular_progress.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  Widget build(BuildContext context, ChatController controller) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: black),
          elevation: 0.5,
          backgroundColor: white,
          title: const CommonText(
            text: 'Chat',
          )),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/wa_bg.png'),
                fit: BoxFit.cover)),
        child: StreamBuilder<List<Message>>(
          stream: controller.messagesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final messages = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: messages.isEmpty
                        ? const Center(
                            child: Text('Start your conversation now : )'),
                          )
                        : ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              controller.loadProfileCache(message.profileId);
                              return ChatBubble(
                                message: message,
                                profile:
                                    controller.profileCache[message.profileId],
                              );
                            },
                          ),
                  ),
                  const MessageBarView(),
                ],
              );
            } else {
              return const CommonCircularProgress();
            }
          },
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => ChatController();
}
