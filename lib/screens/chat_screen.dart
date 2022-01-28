import 'package:chattah/auth_screen/FB_login_screen.dart';
import 'package:chattah/screens/own_message_card.dart';
import 'package:chattah/screens/reply_bubble_card.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.name, required this.icon})
      : super(key: key);
  final String name;
  final String icon;
  @override
  // ignore: no_logic_in_create_state
  _ChatScreenState createState() => _ChatScreenState(name, icon);
}

class _ChatScreenState extends State<ChatScreen> {
  String name;
  String icon;
  String currentMenuItem = 'About';
  bool isLoading = true;
  late IO.Socket socket;

  final myController = TextEditingController();

  _ChatScreenState(this.name, this.icon);
//init state
  @override
  void initState() {
    connect();
    super.initState();
  }

//textfield controller
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

//Connect socket.io
  void connect() {
    socket = IO.io(
        'https://chattahbackend.herokuapp.com/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    print(socket.connected);

    socket.emit('test', 'Hello world');

    socket.on('test', (data) => print(data));
  }

//Build screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appbar,
      body: chatscreen,
    );
  }

  Widget get chatscreen {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(
            'lib/assets/wallpaper1.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          ListView(
            padding: const EdgeInsets.only(bottom: 55),
            children: const [
              OwnMessageCard(),
              ReplyBubbleCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              ReplyBubbleCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              ReplyBubbleCard(),
              OwnMessageCard(),
              ReplyBubbleCard(),
              OwnMessageCard(),
              ReplyBubbleCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              ReplyBubbleCard(),
              OwnMessageCard(),
              OwnMessageCard(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: MediaQuery.of(context).size.width - 55,
                  child: Card(
                    margin: const EdgeInsets.only(left: 3, right: 10),
                    shadowColor: Colors.black12,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      minLines: 1,
                      controller: myController,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),

                //send button
                InkWell(
                  onTap: () {
                    socket.emit("message", myController.text);
                    myController.clear();
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar get appbar {
    return AppBar(
      backgroundColor: Colors.blue[200],
      leadingWidth: 80,
      titleSpacing: 1,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(icon),
              )),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          const Text(
            "Active",
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
      actions: [
        PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (BuildContext contesxt) {
              return [
                const PopupMenuItem(
                  child: Text("Delete chat"),
                  value: "Delete chat",
                ),
              ];
            })
      ],
    );
  }

// // load Data
//   void _loadData() {
//     // Delay 2 seconds
//     Future.delayed(const Duration(seconds: 2)).then((value) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
}
