import 'package:get/get.dart';
import 'package:venu_ghee/core/config/app_config.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/branch_admin/presentation/controller/branch_sell_history_controller.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_adaptive_scaffold.dart';

double adaptiveFont(BuildContext context, double size) {
  final w = MediaQuery.of(context).size.width;
  if (w < 600) return size;
  if (w < 1024) return size * 0.90;
  return size * 0.80;
}

class SellHistoryScreen extends StatelessWidget {
  SellHistoryScreen({super.key});

  final SellHistoryController controller = Get.put(SellHistoryController());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return _MobileSellHistoryLayout(controller: controller);

    return BranchAdaptiveScaffold(
      title: 'Sell History',
      mobileBody: _MobileSellHistoryLayout(controller: controller),
      tabletBody: _DesktopSellHistoryBody(controller: controller),
      webBody: _DesktopSellHistoryBody(controller: controller),
    );
  }
}

class _MobileSellHistoryLayout extends StatelessWidget {
  final SellHistoryController controller;

  const _MobileSellHistoryLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: TextWidget(
                text: 'Sell History',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: ColorConstants.redColor,
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.items.isEmpty) {
                  return Center(
                    child: TextWidget(
                      text: 'No sell history found',
                      fontSize: 14.sp,
                      color: ColorConstants.lightTextColor,
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 4.h,
                  ),
                  itemCount: controller.items.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (_, i) =>
                      _MobileSellCard(item: controller.items[i]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
class _DesktopSellHistoryBody extends StatelessWidget {
  final SellHistoryController controller;
  const _DesktopSellHistoryBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'Sell History',
            fontSize: adaptiveFont(context, 22),
            fontWeight: FontWeight.w700,
            color: ColorConstants.textColor,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.items.isEmpty) {
                return Center(
                  child: TextWidget(
                    text: 'No sell history found',
                    fontSize: adaptiveFont(context, 14),
                    color: ColorConstants.lightTextColor,
                  ),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorConstants.borderWhiteColor),
                ),
                child: Column(
                  children: [
                    _TableHeader(),
                    Divider(height: 1, color: ColorConstants.borderWhiteColor),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.items.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: ColorConstants.borderWhiteColor,
                        ),
                        itemBuilder: (_, i) =>
                            _TableRowItem(item: controller.items[i]),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 44),
          const SizedBox(width: 12),
          _hCell(context, 'Product Name', flex: 4),
          _hCell(context, 'Date & Time', flex: 3),
          _hCell(context, 'Customer', flex: 2),
          _hCell(context, 'Mobile', flex: 2),
          _hCell(context, 'Items', flex: 1),
          _hCell(context, 'Payment', flex: 2),
          _hCell(context, 'Amount', flex: 2),
        ],
      ),
    );
  }

  Widget _hCell(BuildContext context, String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: TextWidget(
        text: text,
        fontSize: adaptiveFont(context, 12),
        fontWeight: FontWeight.w600,
        color: ColorConstants.lightTextColor,
      ),
    );
  }
}

class _TableRowItem extends StatelessWidget {
  final SellHistoryItem item;
  const _TableRowItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item.image.isEmpty
                ? Image.asset(
              ImageConstants.productIcon,
              height: 36,
              width: 36,
              fit: BoxFit.cover,
            )
                : Image.network(
              item.image.startsWith('http')
                  ? item.image
                  : '${AppConfig.apiBaseUrl}${item.image}',
              height: 36,
              width: 36,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                ImageConstants.productIcon,
                height: 36,
                width: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            flex: 4,
            child: TextWidget(
              text: item.productName,
              fontSize: adaptiveFont(context, 12),
              fontWeight: FontWeight.w500,
              color: ColorConstants.textColor,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Expanded(
            flex: 3,
            child: TextWidget(
              text: item.dateTime,
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
            ),
          ),

          Expanded(
            flex: 2,
            child: TextWidget(
              text: item.customer,
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Expanded(
            flex: 2,
            child: TextWidget(
              text: item.mobile,
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
            ),
          ),

          Expanded(
            flex: 1,
            child: TextWidget(
              text: '${item.item}',
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _PaymentBadge(
                paymentMode: item.paymentMode,
                small: false,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: TextWidget(
              text: item.amount,
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentBadge extends StatelessWidget {
  final String paymentMode;
  final bool small;
  const _PaymentBadge({required this.paymentMode, required this.small});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (paymentMode.toLowerCase()) {
      case 'cash':
        bgColor = const Color(0xFFE1F5EE);
        textColor = const Color(0xFF0F6E56);
        break;
      case 'bank':
        bgColor = const Color(0xFFE6F1FB);
        textColor = const Color(0xFF185FA5);
        break;
      case 'both':
        bgColor = const Color(0xFFEEEDFE);
        textColor = const Color(0xFF534AB7);
        break;
      default:
        bgColor = ColorConstants.closeColor;
        textColor = ColorConstants.lightTextColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 4 : 4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextWidget(
        text: paymentMode.toUpperCase(),
        fontSize: small ? 10.sp : adaptiveFont(context, 10),
        fontWeight: FontWeight.w600,
        color: textColor,
        textAlign: TextAlign.center,
      ),
    );
  }
}
// class _DesktopSellHistoryBody extends StatelessWidget {
//   final SellHistoryController controller;
//
//   const _DesktopSellHistoryBody({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextWidget(
//             text: 'Complete Sell History',
//             fontSize: adaptiveFont(context, 22),
//             fontWeight: FontWeight.w700,
//             color: ColorConstants.textColor,
//           ),
//           const SizedBox(height: 20),
//
//           // Table container
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (controller.items.isEmpty) {
//                 return Center(
//                   child: TextWidget(
//                     text: 'No sell history found',
//                     fontSize: adaptiveFont(context, 14),
//                     color: ColorConstants.lightTextColor,
//                   ),
//                 );
//               }
//
//               return Container(
//                 decoration: BoxDecoration(
//                   color: ColorConstants.primaryColor,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: ColorConstants.borderWhiteColor),
//                 ),
//                 child: Column(
//                   children: [
//                     _TableHeader(),
//                     Divider(height: 1, color: ColorConstants.borderWhiteColor),
//                     Expanded(
//                       child: ListView.separated(
//                         physics: const BouncingScrollPhysics(),
//                         itemCount: controller.items.length,
//                         separatorBuilder: (_, __) => Divider(
//                           height: 1,
//                           color: ColorConstants.borderWhiteColor,
//                         ),
//                         itemBuilder: (_, i) =>
//                             _TableRowItem(item: controller.items[i]),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _MobileSellCard extends StatelessWidget {
  final SellHistoryItem item;

  const _MobileSellCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorConstants.borderWhiteColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: item.image.isEmpty
                    ? Image.asset(
                        ImageConstants.productIcon,
                        height: 44.h,
                        width: 44.w,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        item.image.startsWith('http')
                            ? item.image
                            : '${AppConfig.apiBaseUrl}${item.image}',
                        height: 44.h,
                        width: 44.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          ImageConstants.productIcon,
                          height: 44.h,
                          width: 44.w,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: item.productName,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textColor,
                    ),
                    SizedBox(height: 2.h),
                    TextWidget(
                      text: item.dateTime,
                      fontSize: 11.sp,
                      color: ColorConstants.lightTextColor,
                    ),
                  ],
                ),
              ),
              // Icon(
              //   Icons.edit_outlined,
              //   size: 16.sp,
              //   color: ColorConstants.lightTextColor,
              // ),
            ],
          ),

          SizedBox(height: 10.h),
          Divider(height: 1, color: ColorConstants.borderWhiteColor),
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PaymentBadge(paymentMode: item.paymentMode, small: true),
              // _StatusBadge(isInProgress: item.isInProgress, small: true),
              TextWidget(
                text: 'Mo.  ${item.mobile}',
                fontSize: 12.sp,
                color: ColorConstants.lightTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
