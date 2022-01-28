import 'package:chattah/custom_uI/chat_card.dart';
import 'package:chattah/Models/chat_model.dart';
import 'package:flutter/material.dart';

class Userpage extends StatefulWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  List<ChatModel> chatcards = [
    ChatModel(
        name: 'Lymeng',
        icon: 'lib/assets/profile.png',
        time: '20:20',
        currentMessage: 'Hi',
        isGroup: false),
    ChatModel(
        name: 'Chea',
        icon: 'lib/assets/profile.png',
        time: '20:20',
        currentMessage: 'Hi',
        isGroup: false),
    ChatModel(
        name: 'kakada',
        icon: 'lib/assets/profile.png',
        time: '20:20',
        currentMessage: 'Hi',
        isGroup: false),
    ChatModel(
        name: 'Seyha',
        icon: 'lib/assets/profile.png',
        time: '20:20',
        currentMessage: 'Hi',
        isGroup: false),
    ChatModel(
        name: 'Petter',
        icon: 'lib/assets/profile.png',
        time: '20:20',
        currentMessage: 'Hi',
        isGroup: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: (context, index) => Chatcard(
        chatModel: chatcards[index],
      ),
      itemCount: chatcards.length,
    )
        // children: const [
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        // ],
        );
  }
}
