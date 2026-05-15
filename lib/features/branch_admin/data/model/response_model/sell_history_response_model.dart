class SellHistoryResponseModel {
  int? status;
  String? message;
  List<SaleModel>? sales;

  SellHistoryResponseModel({this.status, this.message, this.sales});

  SellHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['sales'] != null) {
      sales = (json['sales'] as List)
          .map((v) => SaleModel.fromJson(v))
          .toList();
    }
  }
}

class SaleModel {
  int? branchId;
  String? customerName;
  String? customerMobile;
  double? totalAmount;
  String? paymentMode;
  double? cashAmount;
  double? bankAmount;
  String? orderType;
  String? deliveryStatus;
  String? deliveredAt;
  int? id;
  String? timestamp;
  List<SaleItemModel>? items;

  SaleModel({
    this.branchId, this.customerName, this.customerMobile,
    this.totalAmount, this.paymentMode, this.cashAmount,
    this.bankAmount, this.orderType, this.deliveryStatus,
    this.deliveredAt, this.id, this.timestamp, this.items,
  });

  SaleModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    totalAmount = (json['total_amount'] as num?)?.toDouble();
    paymentMode = json['payment_mode'];
    cashAmount = (json['cash_amount'] as num?)?.toDouble();
    bankAmount = (json['bank_amount'] as num?)?.toDouble();
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    deliveredAt = json['delivered_at'];
    id = json['id'];
    timestamp = json['timestamp'];
    if (json['items'] != null) {
      items = (json['items'] as List)
          .map((v) => SaleItemModel.fromJson(v))
          .toList();
    }
  }
}

class SaleItemModel {
  int? productId;
  int? quantity;
  double? pricePerUnit;
  String? productImage;
  String? productName;

  SaleItemModel({
    this.productId,
    this.quantity,
    this.pricePerUnit,
    this.productImage,
    this.productName,
  });

  SaleItemModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    pricePerUnit = (json['price_per_unit'] as num?)?.toDouble();
    productImage = json['product_image'];
    productName = json['product_name'];
  }
}