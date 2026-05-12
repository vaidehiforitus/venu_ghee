class LoginResponseModel {
  int? status;
  String? message;
  List<User>? user;

  User? get firstUser => (user != null && user!.isNotEmpty) ? user!.first : null;
  String? get accessToken => firstUser?.accessToken;
  String? get refreshToken => firstUser?.refreshToken;
  String? get userType => firstUser?.type;
  String? get userName => firstUser?.name;
  int? get userId => firstUser?.id;

  LoginResponseModel({this.status, this.message, this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? type;
  String? accessToken;
  String? refreshToken;
  String? tokenType;

  User({
    this.id,
    this.name,
    this.email,
    this.type,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['type'] = type;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    return data;
  }
}