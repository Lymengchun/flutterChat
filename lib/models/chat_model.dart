class ChatModel {
  late String name;
  late String icon;
  late bool isGroup;
  late String time;
  late String currentMessage;
  ChatModel(
      {required this.name,
      required this.isGroup,
      required this.icon,
      required this.time,
      required this.currentMessage});
}
