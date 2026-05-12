class GetProductBranchListResponseModel {
  int? status;
  String? message;
  List<ProductModel>? products;

  GetProductBranchListResponseModel({this.status, this.message, this.products});

  // GetProductBranchListResponseModel.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  //   message = json['message'];
  //   if (json['products'] != null) {
  //     products = <ProductModel>[];
  //     json['products'].forEach((v) {
  //       products!.add(ProductModel.fromJson(v));
  //     });
  //   }
  // }
// fromJson ne Map accept karavo — products key ander List che
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
  int? price;
  String? unitType;
  int? weightVolume;
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
    price = json['price'];
    unitType = json['unit_type'];
    weightVolume = json['weight_volume'];
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

  Stocks({this.productId, this.quantity, this.productName});

  Stocks.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['product_name'] = productName;
    return data;
  }
}
