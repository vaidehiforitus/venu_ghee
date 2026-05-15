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
  String? get ownerName   => firstUser?.ownerName;
  String? get branchName  => firstUser?.branchName;
  String? get image       => firstUser?.image;
  String? get mobileNumber => firstUser?.mobileNumber;

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
  String? ownerName;
  String? branchName;
  String? image;
  String? mobileNumber;
  String? address;
  String? account;
  String? ifscCode;
  String? bankName;

  User({
    this.id, this.name, this.email, this.type,
    this.accessToken, this.refreshToken, this.tokenType,
    this.ownerName, this.branchName, this.image,
    this.mobileNumber, this.address, this.account,
    this.ifscCode, this.bankName,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    ownerName = json['owner_name'];
    branchName = json['branch_name'];
    image = json['image'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    account = json['account'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'name': name, 'email': email, 'type': type,
      'access_token': accessToken, 'refresh_token': refreshToken,
      'token_type': tokenType, 'owner_name': ownerName,
      'branch_name': branchName, 'image': image,
      'mobile_number': mobileNumber, 'address': address,
      'account': account, 'ifsc_code': ifscCode, 'bank_name': bankName,
    };
  }
}