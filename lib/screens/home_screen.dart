import 'dart:convert';
import 'dart:io';

import 'package:chattah/pages/chat_page.dart';
import 'package:chattah/pages/user_page.dart';
import 'package:chattah/screens/drawer_widget.dart';
import 'package:chattah/auth_screen/FB_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userObj}) : super(key: key);
  final Map userObj;
  @override
  // ignore: no_logic_in_create_state
  _HomeScreenState createState() => _HomeScreenState(userObj);
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Color primaryColor = const Color(0xFF010B41);
  Color secondaryColor = const Color.fromARGB(255, 56, 1, 144);
  late TabController _controller;
  Map userObj;
  List users = [];
  List chats = [];

  _HomeScreenState(this.userObj);
  @override
  void initState() {
    super.initState();
    fetchUser();
    // fetchChat();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  fetchUser() async {
    String url = "http://chattahbackend.herokuapp.com/api/";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${userObj['token']}"
      },
    );
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body)['response'];
      // print('users item:$items');

      for (var i = 0; i <= items.length; i++) {
        if (items[i]['_id'] == userObj['user']['_id']) {
          setState(() {
            items.remove(items[i]);
            users = items;
          });

          break;
        }
      }
    }
  }

  // fetchChat() async {
  //   String url = "https://chattahbackend.herokuapp.com/api/chat/getownchat";

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       HttpHeaders.contentTypeHeader: "application/json",
  //       HttpHeaders.authorizationHeader: "Bearer ${userObj['token']}"
  //     },
  //     body:jsonEncode({
  //       'sourceId':userObj['user']['_id']
  //     })
  //   );

  //   if (response.statusCode == 200) {
  //     var items = jsonDecode(response.body)['response'];
  //     // print('items:$items');
        
  //     setState(() {
  //           users = items;
  //         });
 
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showMyDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          
            title: const Text(
              'CHAT TAH',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              // IconButton(
              //     onPressed: () {},
              //     icon: SvgPicture.asset(
              //       'lib/assets/search.svg',
              //       color: Colors.white,
              //       width: 150,
              //       height: 150,
              //     )),
              PopupMenuButton<String>(itemBuilder: (BuildContext context) {
                return [
                  // const PopupMenuItem(
                  //   child: Text("New Group"),
                  //   value: "New Group",
                  // ),
                  // PopupMenuItem(
                  //   onTap: () {},
                  //   child: const Text("Profile"),
                  //   value: "Profile",
                  // ),
                  PopupMenuItem(
                    child: const Text("Logout"),
                    value: "Logout",
                    onTap: () {
                      FacebookAuth.instance.logOut().then((value) {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ];
              }),
            ],
            backgroundColor: primaryColor,
            bottom: TabBar(
              controller: _controller,
              tabs: const [
                Tab(
                  text: "Chats",
                ),
                Tab(text: "Users")
              ],
              labelColor: Colors.white,
              unselectedLabelStyle: const TextStyle(fontSize: 15),
            )),
        body: TabBarView(
          controller: _controller,
          children: [
             const Chatpage(),
            Userpage(
              users: users,
              userObj: userObj,
            )
          ],
        ),
        drawer: DrawerWidget(
          userObj: userObj,
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('CHAT TAH',style: TextStyle(fontWeight: FontWeight.bold),),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}