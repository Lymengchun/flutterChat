import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )),
          color: const Color(0xFFB2F7EF),
          child: Stack(
            children: [
              const Padding(
                  padding: EdgeInsets.only(
                      top: 20, bottom: 25, left: 10, right: 100)),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Hey hello ",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(1, 11, 65, 0.5)),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 2,
                child: Row(
                  children: const [
                    Text(
                      "20:58",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.done_all,
                      color: Colors.grey,
                      size: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
