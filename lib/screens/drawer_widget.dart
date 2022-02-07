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
          child: ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                        child: Image.asset('lib/assets/profile.png'))),
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
