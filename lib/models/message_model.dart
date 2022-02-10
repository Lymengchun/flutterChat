class MessageModel{
  String type;
  String message;
  String time;
  MessageModel({
     required this.message,required this.type,required this.time
  });

  factory MessageModel.fromJson(Map<String,dynamic> json){
    return MessageModel(
      message: json['message'], 
      time: json['time'], 
      type: json['type']
     
    );
  }
}