class RegisterformModel {
  String email;
  String username;
  String password;
  String retype;

  RegisterformModel({
    required this.email,
    required this.username,
    required this.password,
    required this.retype
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email,
      'username': username,
      'password': password,
      'retype': retype
    };

    return map;
  }
}