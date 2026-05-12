import 'package:get/get.dart';

class SellHistoryItem {
  final String productName;
  final String dateTime;
  final String customer;
  final String mobile;
  final int item;
  final String amount;
  final bool isInProgress;
  final String image;

  const SellHistoryItem({
    required this.productName,
    required this.dateTime,
    required this.customer,
    required this.mobile,
    required this.item,
    required this.amount,
    required this.isInProgress,
    required this.image,
  });
}

class SellHistoryController extends GetxController {
  final RxBool isLoading = false.obs;

  final RxList<SellHistoryItem> items = <SellHistoryItem>[
    const SellHistoryItem(
      productName: 'Cow Pure Desi Ghee',
      dateTime: '2026-05-26 12:05:09',
      customer: 'mayur patel',
      mobile: '+91 12356 85236',
      item: 5,
      amount: 'Chaman Bhai',
      isInProgress: true,
      image: 'assets/images/product_icon.png',
    ),
    const SellHistoryItem(
      productName: 'Buffalo Pure Desi Ghee',
      dateTime: '2026-05-26 12:05:09',
      customer: 'mayur patel',
      mobile: '+91 12356 85236',
      item: 5,
      amount: 'Chaman Bhai',
      isInProgress: false,
      image: 'assets/images/product_icon.png',
    ),
    const SellHistoryItem(
      productName: 'Cow Pure Desi Ghee',
      dateTime: '2026-05-26 12:05:09',
      customer: 'mayur patel',
      mobile: '+91 12356 85236',
      item: 5,
      amount: 'Chaman Bhai',
      isInProgress: true,
      image: 'assets/images/product_icon.png',
    ),
    const SellHistoryItem(
      productName: 'Buffalo Pure Desi Ghee',
      dateTime: '2026-05-26 12:05:09',
      customer: 'mayur patel',
      mobile: '+91 12356 85236',
      item: 5,
      amount: 'Chaman Bhai',
      isInProgress: false,
      image: 'assets/images/product_icon.png',
    ),
    const SellHistoryItem(
      productName: 'Cow Pure Desi Ghee',
      dateTime: '2026-05-26 12:05:09',
      customer: 'mayur patel',
      mobile: '+91 12356 85236',
      item: 5,
      amount: 'Chaman Bhai',
      isInProgress: true,
      image: 'assets/images/product_icon.png',
    ),
  ].obs;
}