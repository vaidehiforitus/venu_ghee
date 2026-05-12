class AddNewBranchRequestModel {
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
  List<InitialStocks>? initialStocks;

  AddNewBranchRequestModel(
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
        this.initialStocks});

  AddNewBranchRequestModel.fromJson(Map<String, dynamic> json) {
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
    if (json['initial_stocks'] != null) {
      initialStocks = <InitialStocks>[];
      json['initial_stocks'].forEach((v) {
        initialStocks!.add(new InitialStocks.fromJson(v));
      });
    }
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
    if (initialStocks != null) {
      data['initial_stocks'] =
          initialStocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InitialStocks {
  int? productId;
  int? quantity;

  InitialStocks({this.productId, this.quantity});

  InitialStocks.fromJson(Map<String, dynamic> json) {
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
