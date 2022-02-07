import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatelessWidget {
  const loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7BDFF2),
      child: const Center(child: SpinKitSpinningLines(color: Color(0xFFFFFFFF),size: 50.0,),),
    );
  }
}