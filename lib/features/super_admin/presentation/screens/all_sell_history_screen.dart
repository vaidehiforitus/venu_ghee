import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/all_sell_history_model.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/all_sell_history_controller.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

double adaptiveFont(BuildContext context, double size) {
  final w = MediaQuery.of(context).size.width;
  if (w < 600) return size;
  if (w < 1024) return size * 0.90;
  return size * 0.80;
}

class AllSellHistoryScreen extends StatelessWidget {
  AllSellHistoryScreen({super.key});

  final AllSellHistoryController controller = Get.put(
    AllSellHistoryController(),
  );

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) {
      return _MobileLayout(controller: controller);
    }

    return AdaptiveScaffold(
      title: 'All Sell History',
      mobileBody: _MobileLayout(controller: controller),
      tabletBody: _DesktopBody(controller: controller),
      webBody: _DesktopBody(controller: controller),
    );
  }}

// ── DESKTOP BODY ───────────────────────────────────────────
class _DesktopBody extends StatelessWidget {
  final AllSellHistoryController controller;
  const _DesktopBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
                () => Row(
              children: [
                _MetricCard(
                  label: 'Total Sales',
                  value: controller.formatAmount(controller.totalSales.value),
                  sub: '${controller.totalOrders.value} orders',
                  valueColor: const Color(0xFF2E7D32),
                ),
                const SizedBox(width: 12),
                _MetricCard(
                  label: 'Total Orders',
                  value: '${controller.totalOrders.value}',
                  sub: 'All branches',
                  valueColor: const Color(0xFF185FA5),
                ),
                const SizedBox(width: 12),
                _MetricCard(
                  label: 'Cash Sales',
                  value: controller.formatAmount(controller.cashSales.value),
                  sub: '',
                  valueColor: const Color(0xFF854F0B),
                ),
                const SizedBox(width: 12),
                _MetricCard(
                  label: 'Bank Sales',
                  value: controller.formatAmount(controller.bankSales.value),
                  sub: '',
                  valueColor: const Color(0xFF534AB7),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Table
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.filteredItems.isEmpty) {
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
                    Divider(
                      height: 1,
                      color: ColorConstants.borderWhiteColor,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.filteredItems.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: ColorConstants.borderWhiteColor,
                        ),
                        itemBuilder: (_, i) => _DesktopRow(
                          item: controller.filteredItems[i],
                          controller: controller,
                        ),
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

// ── TABLE HEADER ───────────────────────────────────────────
class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _h(context, '#', flex: 1),
          _h(context, 'Customer', flex: 3),
          _h(context, 'Mobile', flex: 2),
          _h(context, 'Branch', flex: 1),
          _h(context, 'Items', flex: 1),
          _h(context, 'Payment', flex: 2),
          _h(context, 'Cash', flex: 2),
          _h(context, 'Bank', flex: 2),
          _h(context, 'Total', flex: 2),
          _h(context, 'Date & Time', flex: 3),
        ],
      ),
    );
  }

  Widget _h(BuildContext ctx, String t, {required int flex}) => Expanded(
    flex: flex,
    child: TextWidget(
      text: t,
      fontSize: adaptiveFont(ctx, 11),
      fontWeight: FontWeight.w600,
      color: ColorConstants.lightTextColor,
    ),
  );
}

// ── DESKTOP ROW ────────────────────────────────────────────
class _DesktopRow extends StatelessWidget {
  final AllSaleItem item;
  final AllSellHistoryController controller;
  const _DesktopRow({required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    final totalItems =
    item.items.fold<int>(0, (sum, e) => sum + e.quantity);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextWidget(
              text: '#${item.id}',
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextWidget(
              text: item.customerName,
              fontSize: adaptiveFont(context, 12),
              fontWeight: FontWeight.w500,
              color: ColorConstants.textColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: TextWidget(
              text: item.customerMobile,
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: _BranchChip(branchId: item.branchId),
          ),
          Expanded(
            flex: 1,
            child: TextWidget(
              text: '$totalItems',
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: _PaymentBadge(mode: item.paymentMode).paddingOnly(right: 10),
          ),
          Expanded(
            flex: 2,
            child: TextWidget(
              text: controller.formatAmount(item.cashAmount),
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: TextWidget(
              text: controller.formatAmount(item.bankAmount),
              fontSize: adaptiveFont(context, 12),
              color: ColorConstants.lightTextColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: TextWidget(
              text: controller.formatAmount(item.totalAmount),
              fontSize: adaptiveFont(context, 12),
              fontWeight: FontWeight.w600,
              color: ColorConstants.textColor,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextWidget(
              text: item.timestamp,
              fontSize: adaptiveFont(context, 11),
              color: ColorConstants.lightTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── MOBILE LAYOUT ──────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  final AllSellHistoryController controller;
  const _MobileLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                child: Row(
                  children: [
                    TextWidget(
                      text: 'All Sell History',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.redColor,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: controller.fetchAllSales,
                      child: Icon(
                        Icons.refresh,
                        size: 22,
                        color: ColorConstants.lightTextColor,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _SearchBar(controller: controller),
              ),
              SizedBox(height: 10.h),

              // Summary horizontal scroll
              Obx(
                    () => SizedBox(
                  height: 72.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      _MobileMetric(
                        'Total Sales',
                        controller.formatAmount(controller.totalSales.value),
                        const Color(0xFF2E7D32),
                      ),
                      _MobileMetric(
                        'Orders',
                        '${controller.totalOrders.value}',
                        const Color(0xFF185FA5),
                      ),
                      _MobileMetric(
                        'Cash',
                        controller.formatAmount(controller.cashSales.value),
                        const Color(0xFF854F0B),
                      ),
                      _MobileMetric(
                        'Bank',
                        controller.formatAmount(controller.bankSales.value),
                        const Color(0xFF534AB7),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.filteredItems.isEmpty) {
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
                    itemCount: controller.filteredItems.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, i) => _MobileCard(
                      item: controller.filteredItems[i],
                      controller: controller,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── MOBILE CARD ────────────────────────────────────────────
class _MobileCard extends StatelessWidget {
  final AllSaleItem item;
  final AllSellHistoryController controller;
  const _MobileCard({required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    final totalItems =
    item.items.fold<int>(0, (sum, e) => sum + e.quantity);

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: item.customerName,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textColor,
                    ),
                    SizedBox(height: 2.h),
                    TextWidget(
                      text: item.customerMobile,
                      fontSize: 12.sp,
                      color: ColorConstants.lightTextColor,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextWidget(
                    text: controller.formatAmount(item.totalAmount),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textColor,
                  ),
                  SizedBox(height: 2.h),
                  TextWidget(
                    text: item.timestamp,
                    fontSize: 10.sp,
                    color: ColorConstants.lightTextColor,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10.h),
          Divider(height: 1, color: ColorConstants.borderWhiteColor),
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PaymentBadge(mode: item.paymentMode),
              Row(
                children: [
                  _BranchChip(branchId: item.branchId),
                  SizedBox(width: 8.w),
                  TextWidget(
                    text: '$totalItems items',
                    fontSize: 11.sp,
                    color: ColorConstants.lightTextColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── SHARED WIDGETS ─────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  final AllSellHistoryController controller;
  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        onChanged: (v) => controller.searchQuery.value = v,
        style: TextStyle(fontSize: 13, color: ColorConstants.textColor),
        decoration: InputDecoration(
          hintText: 'Search customer, mobile...',
          hintStyle: TextStyle(
            fontSize: 13,
            color: ColorConstants.lightTextColor,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 18,
            color: ColorConstants.lightTextColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorConstants.borderWhiteColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorConstants.borderWhiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorConstants.redColor),
          ),
          filled: true,
          fillColor: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}

class _BranchChip extends StatelessWidget {
  final int? branchId;
  const _BranchChip({required this.branchId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: ColorConstants.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextWidget(
        text: branchId != null ? 'B-$branchId' : 'N/A',
        fontSize: 11,
        color: ColorConstants.lightTextColor,
      ),
    );
  }
}

class _PaymentBadge extends StatelessWidget {
  final String mode;
  const _PaymentBadge({required this.mode});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (mode.toLowerCase()) {
      case 'cash':
        bg = const Color(0xFFE1F5EE);
        fg = const Color(0xFF0F6E56);
        break;
      case 'bank':
        bg = const Color(0xFFE6F1FB);
        fg = const Color(0xFF185FA5);
        break;
      case 'both':
        bg = const Color(0xFFEEEDFE);
        fg = const Color(0xFF534AB7);
        break;
      default:
        bg = ColorConstants.closeColor;
        fg = ColorConstants.lightTextColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: TextWidget(
        text: mode.toUpperCase(),
        fontSize: 10,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w600,
        color: fg,
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label, value, sub;
  final Color valueColor;
  const _MetricCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstants.borderWhiteColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: label,
              fontSize: 12,
              color: ColorConstants.lightTextColor,
            ),
            const SizedBox(height: 4),
            TextWidget(
              text: value,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
            if (sub.isNotEmpty)
              TextWidget(
                text: sub,
                fontSize: 11,
                color: ColorConstants.lightTextColor,
              ),
          ],
        ),
      ),
    );
  }
}

class _MobileMetric extends StatelessWidget {
  final String label, value;
  final Color color;
  const _MobileMetric(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            text: label,
            fontSize: 11.sp,
            color: ColorConstants.lightTextColor,
          ),
          TextWidget(
            text: value,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }
}