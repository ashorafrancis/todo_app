class UserModel {
  String name;
  String age;
  String dob;

  UserModel({required this.name, required this.age, required this.dob});

  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'dob': dob};

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name'], age: json['age'], dob: json['dob']);
  }
}
