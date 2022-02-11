
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Chatpage extends StatefulWidget {
  const Chatpage({Key? key})
      : super(key: key);

  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
 bool isloading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Scaffold(
            body:Text('coming soon...')),
            isloading
              ? Container(
                
                color: Colors.white,
                child: const SpinKitSquareCircle(
                    color: Color(0xFF010B41),
                    size: 50,
                  ),
              )
              : Container(),
      ],
    );
  }


}
