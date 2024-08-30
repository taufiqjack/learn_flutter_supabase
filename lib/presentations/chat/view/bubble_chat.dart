import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';
import 'package:learn_flutter_supabase/core/models/message_model.dart';
import 'package:learn_flutter_supabase/core/models/user_model.dart';
import 'package:learn_flutter_supabase/presentations/widgets/common_textstyle.dart';
import 'package:timeago/timeago.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    this.profile,
  }) : super(key: key);

  final Message message;
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContents = [
      if (!message.isMine)
        profile == null
            ? SkeletonAnimation(
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: greyLightFour)),
              )
            : CircleAvatar(
                child: CommonText(
                  text: profile!.username.substring(0, 2),
                  color: white,
                ),
              ),
      const SizedBox(width: 12),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine ? greenFour : greyTwo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CommonText(
            text: message.content,
            color: white,
          ),
        ),
      ),
      const SizedBox(width: 12),
      CommonText(text: format(message.createdAt, locale: 'en_short')),
      const SizedBox(width: 60),
    ];
    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
