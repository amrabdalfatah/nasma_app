import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/message_bubble.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({
    super.key,
  });

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(Dimensions.height10),
      reverse: true,
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {},
          child: MessageBubble.first(
            username: 'userCode',
            message: 'text',
            isMe: true,
            // isMe: AppConstants.userId == currentMessageUserId,
          ),
        );
      },
    );
  }
}
