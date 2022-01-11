import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Color primaryColor = const Color(0xFF010B41);
  Color secondaryColor = const Color(0xFF7BDFF2);
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'ChatTah',
            style: TextStyle(fontSize: 25, color: Colors.white),
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
                const PopupMenuItem(
                  child: Text("Logout"),
                  value: "Logout",
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
        children: const [Text("Chats"), Text("Users")],
      ),
    );
  }
}
