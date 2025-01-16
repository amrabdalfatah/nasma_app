import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nasma_app/features/home/presentation/screens/breathing_session_view.dart';
import 'package:nasma_app/features/home/presentation/screens/home_view.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/chat_messages.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/new_message.dart';

class ChatView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breabot'),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => HomeView());
          },
          icon: Icon(Icons.home),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(() => BreathingSessionView(
                    result: result,
                    cycle: cycle,
                    level: level,
                  ));
            },
            icon: Icon(FontAwesomeIcons.circleNotch),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          const Divider(),
          NewMessage(),
        ],
      ),
    );
  }
}
