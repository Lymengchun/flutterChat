import 'package:chattah/models/chat_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chattah/Models/chat_model.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  bool checkUserObj(userObj) {
    if (userObj == {}) {
      return true;
    } else {
      return false;
    }
  }

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
              const Padding(
                padding: EdgeInsets.only(top: 5, left: 20),
                child: Text(
                  "Default",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "default",
                  style: TextStyle(color: Colors.black54),
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
