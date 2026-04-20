import 'dart:convert';

class UserModel {
  String name;
  String age;
  String dob;

  UserModel({required this.name, required this.age, required this.dob});

  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'dob': dob};

  factory UserModel.fromJson(String source) {
    final data = json.decode(source);
    return UserModel(name: data['name'], age: data['age'], dob: data['dob']);
  }
}
