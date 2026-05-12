import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/branch_admin/presentation/controller/branch_dashboard_controller.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_adaptive_scaffold.dart';

class BranchDashboardScreen extends StatelessWidget {
  BranchDashboardScreen({super.key});

  final BranchDashboardController controller = Get.put(BranchDashboardController());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    if (w < 600) return _MobileDashboardLayout(controller: controller);

    return BranchAdaptiveScaffold(
      title: 'Dashboard',
      mobileBody: _MobileDashboardLayout(controller: controller),
      tabletBody: _DesktopDashboardBody(controller: controller),
      webBody: _DesktopDashboardBody(controller: controller),
    );
  }
}

class _MobileDashboardLayout extends StatelessWidget {
  final BranchDashboardController controller;
  const _MobileDashboardLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Hello Admin!',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.redColor,
                ),
                24.0.height,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: controller.stats.length,
                  itemBuilder: (_, i) =>
                      _StatCard(stat: controller.stats[i], isMobile: true),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _DesktopDashboardBody extends StatelessWidget {
  final BranchDashboardController controller;
  const _DesktopDashboardBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Hello, Admin!',
              fontSize: adaptiveFont(context, 22),
              fontWeight: FontWeight.w700,
              color: ColorConstants.textColor,
            ),
            const SizedBox(height: 24),
            Row(
              children: controller.stats
                  .map(
                    (s) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _StatCard(stat: s, isMobile: false),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        );
      }),
    );
  }
}

class _StatCard extends StatelessWidget {
  final DashboardStat stat;
  final bool isMobile;
  const _StatCard({required this.stat, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile ? EdgeInsets.all(12.r) : const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(isMobile ? 12.r : 12),
        border: Border.all(color: ColorConstants.borderWhiteColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextWidget(
                  text: stat.title,
                  fontSize: isMobile ? 11.sp : adaptiveFont(context, 12),
                  color: ColorConstants.lightTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.all(isMobile ? 6.r : 8),
                decoration: BoxDecoration(
                  color: stat.bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _iconFor(stat.iconPath),
                  size: isMobile ? 16.sp : adaptiveFont(context, 18),
                  color: ColorConstants.redColor,
                ),
              ),
            ],
          ),
          TextWidget(
            text: stat.value,
            fontSize: isMobile ? 16.sp : adaptiveFont(context, 20),
            fontWeight: FontWeight.w700,
            color: ColorConstants.textColor,
          ),
          Row(
            children: [
              Icon(
                stat.isUp ? Icons.trending_up : Icons.trending_down,
                size: isMobile ? 12.sp : 14,
                color: stat.isUp ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: TextWidget(
                  text: stat.change,
                  fontSize: isMobile ? 9.sp : adaptiveFont(context, 10),
                  color: stat.isUp ? Colors.green : Colors.red,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'order':   return Icons.shopping_bag_outlined;
      case 'sales':   return Icons.bar_chart_outlined;
      case 'pending': return Icons.pending_outlined;
      default:        return Icons.people_outline;
    }
  }
}