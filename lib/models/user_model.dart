class UserModel {
  String name;
  String dob;

  UserModel({required this.name, required this.dob});

  Map<String, dynamic> toJson() => {'name': name, 'dob': dob};

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name'], dob: json['dob']);
  }
}
