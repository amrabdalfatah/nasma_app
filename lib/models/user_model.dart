class UserModel {
  int? id;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;

  UserModel({
    this.id,
    this.email,
    this.userName,
    this.firstName,
    this.lastName,
  });

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    userName = map['username'];
    email = map['email'];
    firstName = map['first_name'];
    lastName = map['last_name'];
  }

  toJson() {
    return {
      'id': id,
      'username': userName,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
