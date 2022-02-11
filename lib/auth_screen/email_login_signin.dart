import 'package:chattah/auth_screen/email_login_signup.dart';
import 'package:chattah/screens/home_screen.dart';
import 'package:chattah/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';

class SignInEmail extends StatefulWidget {
  const SignInEmail({Key? key}) : super(key: key);

  @override
  _SignInEmailState createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final url = 'https://chattahbackend.herokuapp.com/api/login';
  bool isHidepassword = true;
  bool isEmailError = false;
  bool isPasswordNotMatch = false;
  Map userObj = {};
  final _key = GlobalKey<FormState>();
  bool isloading = false;

  late Map data;
  late String message;

  void _togglePassword() {
    setState(() {
      //if isHidepassword true will go false if false will go true
      isHidepassword = !isHidepassword;
    });
  }

  void postSignInData() async {


    setState(()  {
     
       isloading = true;
    });
    try {
      final Response = await http.post(Uri.parse(url), body: {
        "username": emailController.text,
        "password": passwordController.text
      });

      data = json.decode(Response.body);

      message = data["message"];

      if (message == 'Password does not matched!') {
        setState(() {
          isloading = false;
          isPasswordNotMatch = true;
        });
      } else if (message == 'No user found!') {
        setState(() {
          isloading = false;
          isEmailError = true;
        });
      } else if (message == 'Login Successful!') {
        setState(() { 
          isloading = false;
        });

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(userObj: data)));
        _key.currentState!.reset();
      } else {
        setState(() {
          isloading = false;
        });
        print(message);
      }

      print(Response.body);
    } catch (err) {
      print(err);
    }

    if (_key.currentState!.validate()) {
      setState(() {
        passwordController.clear();
      });
      print("Your data is submitted");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            extendBody: true,
            appBar: AppBar(
              elevation: 0,
              title: Image.asset(
                'lib/assets/Appco__1_-removebg-preview.png',
                scale: 2.6,
                color: Colors.white,
              ),
              centerTitle: true,
              toolbarHeight: 180,
              backgroundColor: const Color(0xFF010B41),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100))),
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: <Widget>[
                  const ListTile(
                    contentPadding:
                        EdgeInsets.only(left: 40, top: 20, bottom: 10),
                    leading: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(1, 11, 65, 0.7)),
                    ),
                  ),
                  Form(
                      key: _key,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(
                                left: 40, right: 40, bottom: 20),
                            child: TextFormField(
                              onTap: () => isEmailError = false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  value = null;
                                  return "Email can not be empty!";
                                } else if (isEmailError) {
                                  value = null;

                                  return "Incorrect email!";
                                } else {
                                  return null;
                                }
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                prefixIconColor: Color(0xFF7BDFF2),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(1, 11, 65, 0.7)),
                                contentPadding: EdgeInsets.only(
                                    left: 20, top: 15, bottom: 15),
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
                              onTap: () => isPasswordNotMatch = false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password can not be empty!";
                                } else if (value.length <= 7) {
                                  return "password should be greater then 8";
                                } else if (isPasswordNotMatch) {
                                  return "Password does not matched!";
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
                                  builder: (context) => const SignupEmail()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Color(0xFF010B41)),
                        ),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 40, top: 10),
                        child: FloatingActionButton(
                          onPressed: postSignInData,
                          backgroundColor: const Color(0xFF010B41),
                          child: const Icon(Icons.arrow_forward),
                        )),
                  ])
                ],
              ),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
            bottomNavigationBar: BottomAppBar(
              color: const Color(0x00ffffff),
              elevation: 0,
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                    color: Color(0xFF010B41),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(150))),
              ),
            ),
          ),
          isloading
              ? Container(
                color: Colors.white,
                child: const SpinKitFadingCube(
                    color: Color(0xFF010B41),
                    size: 50,
                  ),
              )
              : Container()
        ],
      ),
    );
  }
}
