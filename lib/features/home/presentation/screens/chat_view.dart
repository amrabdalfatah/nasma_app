import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/features/home/presentation/screens/breathing_session_view.dart';
import 'package:nasma_app/features/home/presentation/screens/home_view.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/custom_app_bar.dart';

class ChatView extends StatefulWidget {
  final int cycle;
  final int result;
  final String level;
  const ChatView({
    super.key,
    this.cycle = 10,
    this.result = 10,
    this.level = "High",
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrController = ScrollController(
      // initialScrollOffset: 2.0,
      );
  final List<Map<String, String>> messages = [];

  final String apiUrl = 'http://10.0.2.2:8000/api/v1/chat/';

  Future<void> sendMessage() async {
    final userMessage = controller.text;
    if (userMessage.isEmpty) return;
    setState(() {
      messages.add({"sender": 'user', 'text': userMessage});
    });
    controller.clear();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': userMessage,
          'user_id': AppConstants.userModel!.id,
        }),
      );
      if (response.statusCode == 200) {
        final botReply = jsonDecode(response.body)['reply'];
        setState(() {
          messages.add({'sender': 'bot', 'text': botReply});
        });
      } else {
        setState(() {
          messages.add({
            'sender': 'bot',
            'text': 'Error: Unable to communicate with the server.'
          });
        });
      }
    } catch (e) {
      setState(() {
        messages.add({
          'sender': 'bot',
          'text': 'Error: Something went wrong. Please try again later.'
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   title: Text('Breabot'),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,

      //   actions: [

      //   ],
      // ),
      // I guess not. All I can think about are my exams.
      body: Column(
        children: [
          CustomAppBar(
            child: Center(
              child: SizedBox(
                height: Dimensions.height50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.offAll(() => HomeView());
                      },
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                    BigText(
                      text: 'Breabot',
                      size: Dimensions.font20,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.offAll(() => BreathingSessionView(
                              result: widget.result,
                              cycle: widget.cycle,
                              level: widget.level,
                            ));
                      },
                      icon: Icon(FontAwesomeIcons.circleNotch),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(Dimensions.height10),
              // dragStartBehavior: DragStartBehavior.down,
              // controller: scrController,
              itemCount: messages.length,
              itemBuilder: (ctx, index) {
                final reversed = messages.reversed.toList();
                final message = reversed[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color:
                          isUser ? AppColors.forthColor : AppColors.secondColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
                // return MessageBubble.first(
                //   username: isUser ? 'user' : "bot",
                //   message: message['text']!,
                //   isMe: isUser,
                // );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
          // const Divider(),
          // NewMessage(),
        ],
      ),
    );
  }
}
