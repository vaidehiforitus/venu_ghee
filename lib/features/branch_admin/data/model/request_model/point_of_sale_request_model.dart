class SaleRequestModel {
  final int branchId;
  final String customerName;
  final String customerMobile;
  final double totalAmount;
  final String paymentMode;
  final double cashAmount;
  final double bankAmount;
  final String orderType;
  final List<SaleItem> items;

  SaleRequestModel({
    required this.branchId,
    required this.customerName,
    required this.customerMobile,
    required this.totalAmount,
    required this.paymentMode,
    required this.cashAmount,
    required this.bankAmount,
    required this.orderType,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    'branch_id': branchId,
    'customer_name': customerName,
    'customer_mobile': customerMobile,
    'total_amount': totalAmount,
    'payment_mode': paymentMode,
    'cash_amount': cashAmount,
    'bank_amount': bankAmount,
    'order_type': orderType,
    'delivery_status': '',
    'delivered_at': '',
    'items': items.map((e) => e.toJson()).toList(),
  };
}

class SaleItem {
  final int productId;
  final int quantity;
  final double pricePerUnit;

  SaleItem({
    required this.productId,
    required this.quantity,
    required this.pricePerUnit,
  });

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
    'price_per_unit': pricePerUnit,
  };
}