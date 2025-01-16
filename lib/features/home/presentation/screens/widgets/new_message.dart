import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/dimensions.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    super.key,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  bool uploading = false;
  bool isShowSendButton = false;

  sendMessage() async {
    if (isShowSendButton) {
      final enteredMessage = _messageController.text;
      if (enteredMessage.trim().isEmpty) {
        return;
      }

      _messageController.clear();

      setState(() {
        isShowSendButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        Dimensions.height10,
      ),
      child: uploading
          ? const Center(
              child: LinearProgressIndicator(),
            )
          : Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        setState(() {
                          isShowSendButton = true;
                        });
                      } else {
                        setState(() {
                          isShowSendButton = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 25,
                  child: GestureDetector(
                    onTap: sendMessage,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
