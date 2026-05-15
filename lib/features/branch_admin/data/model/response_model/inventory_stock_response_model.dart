class StockResponseModel {
  int? status;
  String? message;
  List<StockModel>? stocks;

  StockResponseModel({this.status, this.message, this.stocks});

  StockResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['stocks'] != null) {
      stocks = (json['stocks'] as List)
          .map((v) => StockModel.fromJson(v))
          .toList();
    }
  }
}

class StockModel {
  int? productId;
  String? productName;
  String? image;
  double? price;
  int? quantity;

  StockModel({this.productId, this.productName, this.image, this.price, this.quantity});

  StockModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    image = json['image'];
    price = (json['price'] as num?)?.toDouble();
    quantity = json['quantity'];
  }
}