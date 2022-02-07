class AllUsers{
  late String id;
  late String name;
  late String email;

  AllUsers({email, id, name});

  factory AllUsers.fromJson(Map<String,dynamic> json){
    return AllUsers(
      id: json['id'],
      name: json['name'],
      email:json ['email'],
    );
  }
}