import 'dart:io';

import 'package:chattah/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  Map userObj = {};
  String image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn
          ? Column(
              children: [
                Image.network(userObj["picture"]["data"]["url"] ?? ''),
                Text(userObj["name"] ?? ''),
                Text(userObj["email"] ?? ''),
                TextButton(
                    onPressed: () {
                      FacebookAuth.instance.logOut().then((value) {
                        setState(() {
                          isLoggedIn = false;
                          userObj = {};
                        });
                      });
                    },
                    child: const Text("Logout"))
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Card(

                //   color: Colors.amber,
                //   shape: RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.only(bottomRight: Radius.circular(25))),
                // ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFF7BDFF2),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(150))),
                  child: Image.asset(
                    "lib/assets/Appco__1_-removebg-preview.png",
                    scale: 2.5,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(1, 11, 65, 0.7)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        leading: const Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size: 30,
                        ),
                        tileColor: Colors.blue,
                        title: const Text(
                          "Continue with Facebook",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                          FacebookAuth.instance.login(permissions: [
                            'public_profile',
                            'email',
                            // 'pages_show_list',
                            // 'pages_messaging',
                            // 'pages_manage_metadata'
                          ]).then((value) {
                            FacebookAuth.instance
                                .getUserData()
                                .then((userData) {
                              setState(() {
                                isLoggedIn = true;
                                userObj = userData;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                            userObj: userData,
                                          )));
                            });
                          });
                        },
                      ),
                    ),
                  ],
                )),
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                      color: Color(0xFF7BDFF2),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(150))),
                )
              ],
            ),
    );
  }
}
