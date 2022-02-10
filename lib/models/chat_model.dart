import 'package:chattah/models/all_users.dart';

class ChatModel {
  late String name;
  late String icon;
  late bool isGroup;
  late String time;
  late String currentMessage;
  
  ChatModel(responseJson, 
      { required this.name ,
       required this.isGroup ,
       required this.icon ,
       required this.time,
       required this.currentMessage });
}
