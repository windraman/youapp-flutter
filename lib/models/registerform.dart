class RegisterformModel {
  String email;
  String username;
  String password;

  RegisterformModel({
    required this.email,
    required this.username,
    required this.password
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email,
      'username': username,
      'password': password
    };

    return map;
  }
}