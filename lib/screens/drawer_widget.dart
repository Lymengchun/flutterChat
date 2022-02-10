import 'package:chattah/models/chat_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chattah/Models/chat_model.dart';

class DrawerWidget extends StatelessWidget {
   const DrawerWidget({
    Key? key,required this.userObj
  }) : super(key: key);
final Map userObj;


  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        Drawer(
          backgroundColor: Colors.blue[200],
          child: ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                        child: Image.network('https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/028d394ffb00cb7a4b2ef9915a384fd9.png?compress=1&resize=500x500'))),
              ),
                Padding(
                padding: const EdgeInsets.only(top: 5, left: 20),
                child: Text(
                  userObj['user']['name'],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  userObj['user']['email'],
                  style:const TextStyle(color: Colors.black54),
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              )
            ],
          ),
        )
      ],
    );
  }
}
