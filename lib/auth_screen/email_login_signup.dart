import 'package:chattah/auth_screen/email_login_signin.dart';
import 'package:chattah/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupEmail extends StatefulWidget {
  const SignupEmail({Key? key}) : super(key: key);

  @override
  _SignupEmailState createState() => _SignupEmailState();
}

class _SignupEmailState extends State<SignupEmail> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final url = 'https://chattahbackend.herokuapp.com/api/register';
  bool isHidepassword = true;
  bool isEmailError = false;
  Map<String, int> userObj = {};
  final _key = GlobalKey<FormState>();

  late Map data;
  late String message;
  @override
  void initState() {
    super.initState();
  }




  void postSignUpData() async {
    try {

      final Response = await http.post(Uri.parse(url), body: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text
      });

       data = json.decode(Response.body);
      setState(() {
        message = data["message"];
      });
      if (message =='Email is already taken!') {
        isEmailError = true;
      }else if(message =='User Added Successfully!'){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(userObj: userObj)));
      }else{
        print(message);
      }
      print(Response.body);
    } catch (err) {
      print(err);
    }

    if (_key.currentState!.validate()) {
      print("Your data is submitted");
        passwordController.clear();
        emailController.clear();
    }
  }

  void _togglePassword() {
    setState(() {
      //if isHidepassword true will go false if false will go true
      isHidepassword = !isHidepassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/Appco__1_-removebg-preview.png',
          scale: 2.6,
        ),
        centerTitle: true,
        toolbarHeight: 180,
        backgroundColor: const Color(0xFF7BDFF2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            const ListTile(
              contentPadding: EdgeInsets.only(left: 40, top: 20, bottom: 10),
              leading: Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(1, 11, 65, 0.7)),
              ),
            ),
            Form(
                key: _key,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, bottom: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "username can not be empty!";
                          } else {
                            return null;
                          }
                        },
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          prefixIconColor: Color(0xFF7BDFF2),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(1, 11, 65, 0.7)),
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 15),
                          hintText: "username",
                          border: InputBorder.none,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: const Color(0xFFB2F7EF),
                    ),
                    Card(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, bottom: 20),
                      child: TextFormField(
                        onTap: ()=>isEmailError = false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email can not be empty!";
                          } else if (isEmailError) {
                            return "Email is already taken!";
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Color(0xFF7BDFF2),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(1, 11, 65, 0.7)),
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 15),
                          hintText: "email",
                          border: InputBorder.none,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: const Color(0xFFB2F7EF),
                    ),
                    Card(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, bottom: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password can not be empty!";
                          } else if (value.length <= 8) {
                            return "password should be greater then 8";
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isHidepassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          prefixIconColor: const Color(0xFF7BDFF2),
                          suffixIcon: InkWell(
                            child: Icon(isHidepassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onTap: _togglePassword,
                          ),
                          labelStyle: const TextStyle(
                              color: Color.fromRGBO(1, 11, 65, 0.7)),
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 15),
                          hintText: "password",
                          border: InputBorder.none,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: const Color(0xFFB2F7EF),
                    ),
                  ],
                )),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInEmail()));
                  },
                  child: const Text(
                    'sign in',
                    style: TextStyle(color: Color(0xFF010B41)),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                  padding: const EdgeInsets.only(right: 40, top: 10),
                  child: FloatingActionButton(
                    onPressed: postSignUpData,
                    backgroundColor: const Color(0xFF010B41),
                    child: const Icon(Icons.arrow_forward),
                  )),
            ])
          ],
        ),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEFF7F6),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
              color: Color(0xFF7BDFF2),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(150))),
        ),
      ),
    );
  }
}
