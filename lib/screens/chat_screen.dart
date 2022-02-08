import 'package:chattah/auth_screen/FB_login_screen.dart';
import 'package:chattah/models/message_model.dart';
import 'package:chattah/screens/own_message_card.dart';
import 'package:chattah/screens/reply_bubble_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required this.icon,
      required this.users,
      required this.userObj})
      : super(key: key);
  final Map userObj;
  final String icon;
  final Map users;
  @override
  // ignore: no_logic_in_create_state
  _ChatScreenState createState() => _ChatScreenState(icon, users, userObj);
}

class _ChatScreenState extends State<ChatScreen> {
  Map userObj;
  String icon;
  Map users;
  String currentMenuItem = 'About';
  bool isLoading = true;
  late IO.Socket socket;
  bool enabled = true;
  bool _needsScroll = false;

  final myController = TextEditingController();
  final ScrollController _controller = ScrollController();

  List<MessageModel> messages = [];

  _ChatScreenState(this.icon, this.users, this.userObj);

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

    socket.onConnect((msg) {
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
      });
    });

    socket.emit('signin', userObj['user']['_id']);
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);
    socket.emit('message',
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(message: message, type: type,time: DateTime.now().toString().substring(10,16));
    setState(() {
      messages.add(messageModel);
    });
  }

  void scroll() async {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

//Build screen
  @override
  Widget build(BuildContext context) {
    if (_needsScroll) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => scroll());
      _needsScroll = false;
    }
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
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("lib/assets/wallpaper1.jpg"),fit: BoxFit.cover)
      ),
      child: Column(
        children: [
          
          Expanded(
            child: ListView.builder(
              itemCount: messages.length+1,
              controller: _controller,
              shrinkWrap: true,
              // padding: const EdgeInsets.only(bottom: 90),
              itemBuilder: (context, index) {
                if(index==messages.length){
                  return Container(height: 50,);
                }
                if (messages[index].type == "source") {
                  return OwnMessageCard(
                    message: messages[index].message,
                    time: messages[index].time,
                  );
                } else {
                  return ReplyBubbleCard(message: messages[index].message,time: messages[index].time,);
                }
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              child: Row(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                      margin: const EdgeInsets.only(
                        left: 3,
                        right: 10,
                      ),
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
                        onTap: () {
                          setState(() {
                            scroll();
                          });
                        },
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),

                  //send button
                  AbsorbPointer(
                    absorbing: !enabled,
                    child: InkWell(
                      onTap: () {
                        scroll();
                        // socket.emit("message", myController.text);
                        if (myController.text.isNotEmpty) {
                          setState(() {
                            enabled = true;
                          });
                          sendMessage(myController.text, userObj['user']['_id'],
                              users['_id']);
                        }
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
                  ),
                ],
              ),
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
                child: Image.network(icon),
              )),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(users['name']),
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
}
