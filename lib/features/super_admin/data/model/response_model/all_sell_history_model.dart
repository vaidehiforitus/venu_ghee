class AllSaleItem {
  final int? branchId;
  final String customerName;
  final String customerMobile;
  final double totalAmount;
  final String paymentMode;
  final double cashAmount;
  final double bankAmount;
  final String orderType;
  final int id;
  final String timestamp;
  final List<SaleItemDetail> items;

  AllSaleItem({
    required this.branchId,
    required this.customerName,
    required this.customerMobile,
    required this.totalAmount,
    required this.paymentMode,
    required this.cashAmount,
    required this.bankAmount,
    required this.orderType,
    required this.id,
    required this.timestamp,
    required this.items,
  });

  factory AllSaleItem.fromJson(Map<String, dynamic> json) {
    return AllSaleItem(
      branchId: json['branch_id'],
      customerName: json['customer_name'] ?? '',
      customerMobile: json['customer_mobile'] ?? '',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      paymentMode: json['payment_mode'] ?? '',
      cashAmount: (json['cash_amount'] ?? 0).toDouble(),
      bankAmount: (json['bank_amount'] ?? 0).toDouble(),
      orderType: json['order_type'] ?? '',
      id: json['id'] ?? 0,
      timestamp: json['timestamp'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => SaleItemDetail.fromJson(e))
          .toList(),
    );
  }
}

class SaleItemDetail {
  final int productId;
  final int quantity;
  final double pricePerUnit;

  SaleItemDetail({
    required this.productId,
    required this.quantity,
    required this.pricePerUnit,
  });

  factory SaleItemDetail.fromJson(Map<String, dynamic> json) {
    return SaleItemDetail(
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      pricePerUnit: (json['price_per_unit'] ?? 0).toDouble(),
    );
  }
}