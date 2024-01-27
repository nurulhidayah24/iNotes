class UserModel {
  late String user_id;
  late String name;
  late String email;
  late String password;

  UserModel(this.user_id, this.name, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'user_id': user_id,
      'name': name,
      'email': email,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
  }
}