import 'package:chattah/pages/chat_page.dart';
import 'package:chattah/pages/user_page.dart';
import 'package:chattah/screens/drawer_widget.dart';
import 'package:chattah/auth_screen/FB_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
  Color secondaryColor = const Color(0xFF7BDFF2);
  late TabController _controller;
  Map userObj;

  _HomeScreenState(this.userObj);
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'CHAT TAH',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'lib/assets/search.svg',
                  color: Colors.white,
                  width: 150,
                  height: 150,
                )),
            PopupMenuButton<String>(itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text("New Group"),
                  value: "New Group",
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: const Text("Profile"),
                  value: "Profile",
                ),
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
          backgroundColor: secondaryColor,
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
        children: const [Chatpage(), Userpage()],
      ),
      drawer: const DrawerWidget(),
    );
  }
}
