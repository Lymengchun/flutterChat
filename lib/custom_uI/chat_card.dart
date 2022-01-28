import 'package:chattah/Models/chat_model.dart';
import 'package:chattah/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class Chatcard extends StatelessWidget {
  const Chatcard({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: ListTile(
        leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(chatModel.icon),
            )),
        title: Text(
          chatModel.name,
        ),
        subtitle: Text(
          chatModel.currentMessage,
        ),
        trailing: Text(chatModel.time),
        tileColor: const Color(0xFFEFF7F6),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(name: chatModel.name, icon: chatModel.icon)));
        },
        onLongPress: () {},
      ),
    );
  }
}
