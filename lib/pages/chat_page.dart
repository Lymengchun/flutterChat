import 'package:chattah/custom_ui/chat_card.dart';
import 'package:chattah/Models/chat_model.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  // List<ChatModel> chatcards = [
  //   ChatModel(
  //       name: 'Lymeng',
  //       icon: 'lib/assets/myprofile.jpg',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Chea',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'kakada',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Seyha',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Petter',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Petter',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Petter',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Petter',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Petter',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  //   ChatModel(
  //       name: 'Petter',
  //       icon: 'lib/assets/profile.png',
  //       time: '20:20',
  //       currentMessage: 'Hi',
  //       isGroup: false),
  // ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:Text("Hello")
    //      ListView.builder(
    //   itemCount: chatcards.length,
    //   itemBuilder: (context, index) => Chatcard(
    //     chatModel: chatcards[index],
    //   ),
    // )
        // children: const [
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
        //   Chatcard(),
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
