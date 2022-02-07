import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:chattah/custom_uI/chat_card.dart';
import 'package:chattah/Models/chat_model.dart';
import 'package:chattah/models/all_users.dart';
import 'package:chattah/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Userpage extends StatefulWidget {
   const Userpage({Key? key,required this.users,required this.userObj}) : super(key: key);
    final List users;
    final Map userObj;
  @override
  _UserpageState createState() => _UserpageState(users,userObj);
}

class _UserpageState extends State<Userpage> {

  List users;
  Map userObj;
  bool isLoading = false;
  var name;
  var email;

  _UserpageState(this.users,this.userObj);

  @override
  initState(){
    super.initState();
  }

  // List<ChatModel> chatcards = [
  //   ChatModel(
  //       name: 'Lymeng',
  //       icon: 'lib/assets/profile.png',
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
  //       name: 'Petter1',
  //       icon: 'lib/assets/profile.png',
  //       time: '',
  //       currentMessage: '',
  //       isGroup: false),
  // ];

  @override
  Widget build(BuildContext context) {

    return  Stack(
      children:[
        Scaffold(
          body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context,index){
              
            return getCard(users[index]);
          }),
        )
     ,isLoading
            ? Container(
              color: Colors.white,
              child: const SpinKitFadingCube(
                  color: Colors.blue,
                  size: 50,
                ),
            )
            : Container()
      ],
    );
    
  }

  Widget getCard(index){

    name = index['name'];
    email = index['email'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: ListTile(
        leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network('https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/028d394ffb00cb7a4b2ef9915a384fd9.png?compress=1&resize=400x300'),
            )),
        title: Text(
          name,
        ),
        subtitle:  Text(
          email
        ),
        trailing: const Text(""),
        tileColor: const Color(0xFFEFF7F6),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(icon:"https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/028d394ffb00cb7a4b2ef9915a384fd9.png?compress=1&resize=400x300",users: index,userObj: userObj,)));
        },
        onLongPress: () {},
      ),
    );
  }
}
