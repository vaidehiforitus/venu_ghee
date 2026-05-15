class GetBranchDetailsResponseModel {
  int? status;
  String? message;
  List<Branches>? branches;

  GetBranchDetailsResponseModel({this.status, this.message, this.branches});

  GetBranchDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branches {
  String? image;
  String? branchName;
  String? address;
  String? state;
  int? zipCode;
  String? mobileNumber;
  String? ownerName;
  String? email;
  String? password;
  String? accountNumber;
  String? ifscCode;
  String? bankName;
  int? id;
  List<Stocks>? stocks;
  bool? isOpen;

  Branches(
      {this.image,
        this.branchName,
        this.address,
        this.state,
        this.zipCode,
        this.mobileNumber,
        this.ownerName,
        this.email,
        this.password,
        this.accountNumber,
        this.ifscCode,
        this.bankName,
        this.id,
        this.stocks,
        this.isOpen});

  Branches.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    branchName = json['Branch_name'];
    address = json['address'];
    state = json['state'];
    zipCode = json['zip_code'];
    mobileNumber = json['Mobile_number'];
    ownerName = json['owner_name'];
    email = json['email'];
    password = json['password'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    id = json['id'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stocks.fromJson(v));
      });
    }
    isOpen = json['is_open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['Branch_name'] = branchName;
    data['address'] = address;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['Mobile_number'] = mobileNumber;
    data['owner_name'] = ownerName;
    data['email'] = email;
    data['password'] = password;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['bank_name'] = bankName;
    data['id'] = id;
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    data['is_open'] = isOpen;
    return data;
  }
}

class Stocks {
  int? productId;
  int? quantity;

  Stocks({this.productId, this.quantity});

  Stocks.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
