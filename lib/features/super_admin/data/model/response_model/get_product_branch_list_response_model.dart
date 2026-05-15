class GetProductBranchListResponseModel {
  int? status;
  String? message;
  List<ProductModel>? products;

  GetProductBranchListResponseModel({this.status, this.message, this.products});

  GetProductBranchListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['products'] != null) {
      products = (json['products'] as List)
          .map((v) => ProductModel.fromJson(v))
          .toList();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  String? image;
  String? name;
  double? price;
  String? unitType;
  double? weightVolume;
  int? id;
  List<Stocks>? stocks;

  ProductModel(
      {this.image,
        this.name,
        this.price,
        this.unitType,
        this.weightVolume,
        this.id,
        this.stocks});

  ProductModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    price = (json['price'] as num?)?.toDouble();
    // price = json['price'];
    unitType = json['unit_type'];
    weightVolume = (json['weight_volume'] as num?)?.toDouble(); // ← fix
    // weightVolume = json['weight_volume'];
    id = json['id'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['unit_type'] = unitType;
    data['weight_volume'] = weightVolume;
    data['id'] = id;
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stocks {
  int? productId;
  int? quantity;
  String? productName;
  double? price;
  String? image;

  Stocks({this.productId, this.quantity, this.productName, this.image, this.price});

  Stocks.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    productName = json['product_name'];
    price = (json['price'] as num?)?.toDouble();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['product_name'] = productName;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}