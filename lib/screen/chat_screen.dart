import 'package:chattah/screen/own_bubble_message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String currentMenuItem = 'About';
  bool isLoading = true;
  late IO.Socket socket;
//init state
  @override
  void initState() {
    super.initState();
    socket = IO.io(
        'https://photosharebackendnodejs.herokuapp.com/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    socket.emit('test', 'Hello Wolrd');
    super.initState();
    // _loadData();
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
            children: const [
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
              OwnMessageCard(),
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
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    shadowColor: Colors.black12,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
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
            child: SvgPicture.asset(
              'lib/assets/profile.svg',
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Lymeng"),
          Text(
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
                  child: Text("New group"),
                  value: "New group",
                ),
                const PopupMenuItem(
                  child: Text("Logout"),
                  value: "Logout",
                )
              ];
            })
      ],
    );
  }

// load Data
  void _loadData() {
    // Delay 2 seconds
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
