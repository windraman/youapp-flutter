class LoginformModel {
  String email;
  String password;

  LoginformModel({
    required this.email,
    required this.password
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email,
      'password': password
    };

    return map;
  }
}