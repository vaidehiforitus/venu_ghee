// class GetBranchDetailsResponseModel {
//   String? image;
//   String? name;
//   String? location;
//   String? number;
//   String? ownerName;
//   String? email;
//   String? password;
//   String? accountNumber;
//   String? ifscCode;
//   String? bankName;
//   int? id;
//   List<Stocks>? stocks;
//   bool? isOpen;
//
//   GetBranchDetailsResponseModel(
//       {this.image,
//         this.name,
//         this.location,
//         this.number,
//         this.ownerName,
//         this.email,
//         this.password,
//         this.accountNumber,
//         this.ifscCode,
//         this.bankName,
//         this.id,
//         this.stocks,
//         this.isOpen});
//
//   GetBranchDetailsResponseModel.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     name = json['name'];
//     location = json['location'];
//     number = json['number'];
//     ownerName = json['owner_name'];
//     email = json['email'];
//     password = json['password'];
//     accountNumber = json['account_number'];
//     ifscCode = json['ifsc_code'];
//     bankName = json['bank_name'];
//     id = json['id'];
//     if (json['stocks'] != null) {
//       stocks = <Stocks>[];
//       json['stocks'].forEach((v) {
//         stocks!.add(new Stocks.fromJson(v));
//       });
//     }
//     isOpen = json['is_open'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['image'] = image;
//     data['name'] = name;
//     data['location'] = location;
//     data['number'] = number;
//     data['owner_name'] = ownerName;
//     data['email'] = email;
//     data['password'] = password;
//     data['account_number'] = accountNumber;
//     data['ifsc_code'] = ifscCode;
//     data['bank_name'] = bankName;
//     data['id'] = id;
//     if (stocks != null) {
//       data['stocks'] = stocks!.map((v) => v.toJson()).toList();
//     }
//     data['is_open'] = isOpen;
//     return data;
//   }
// }
//
// class Stocks {
//   int? productId;
//   int? quantity;
//   String? productName;
//
//   Stocks({this.productId, this.quantity, this.productName});
//
//   Stocks.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     quantity = json['quantity'];
//     productName = json['product_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['product_id'] = productId;
//     data['quantity'] = quantity;
//     data['product_name'] = productName;
//     return data;
//   }
// }

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
        branches!.add(new Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
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
        stocks!.add(new Stocks.fromJson(v));
      });
    }
    isOpen = json['is_open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['Branch_name'] = this.branchName;
    data['address'] = this.address;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['Mobile_number'] = this.mobileNumber;
    data['owner_name'] = this.ownerName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['id'] = this.id;
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    data['is_open'] = this.isOpen;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
