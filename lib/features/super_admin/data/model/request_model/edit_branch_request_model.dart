class EditBranchRequestModel {
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

  EditBranchRequestModel({
    this.image,
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
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (image != null) data['image'] = image;
    data['name'] = branchName;
    data['location'] = address;
    data['number'] = mobileNumber;
    data['owner_name'] = ownerName;
    data['email'] = email;
    if (password != null && password!.isNotEmpty) {
      data['password'] = password;
    }
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['bank_name'] = bankName;
    return data;
  }
}