class AboutModel {
  String? sId;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  Profile? profile;

  AboutModel(
      {this.sId,
        this.username,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.profile});

  AboutModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? name;
  String? gender;
  String? birthday;
  String? horoscope;
  String? zodiac;
  int? height;
  int? weight;
  List<String>? interests;

  Profile(
      {this.name,
        this.gender,
        this.birthday,
        this.horoscope,
        this.zodiac,
        this.height,
        this.weight,
        this.interests});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    birthday = json['birthday'];
    horoscope = json['horoscope'];
    zodiac = json['zodiac'];
    height = json['height'];
    weight = json['weight'];
    interests = json['interests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['horoscope'] = horoscope;
    data['zodiac'] = zodiac;
    data['height'] = height;
    data['weight'] = weight;
    data['interests'] = interests;
    return data;
  }
}
