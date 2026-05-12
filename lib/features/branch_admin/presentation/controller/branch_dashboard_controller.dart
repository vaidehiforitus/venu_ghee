import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';

class DashboardStat {
  final String title;
  final String value;
  final String change;
  final bool isUp;
  final String iconPath;
  final Color bgColor;

  DashboardStat({
    required this.title,
    required this.value,
    required this.change,
    required this.isUp,
    required this.iconPath,
    required this.bgColor,
  });
}

class BranchDashboardController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<DashboardStat> stats = <DashboardStat>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  Future<void> fetchStats() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 800));
      stats.value = [
        DashboardStat(
          title: 'Total User',
          value: '40,689',
          change: '8.5% Up from yesterday',
          isUp: true,
          iconPath: 'user',
          bgColor: const Color(0xFFEDE9FF),
        ),
        DashboardStat(
          title: 'Total Order',
          value: '10293',
          change: '1.3% Up from past week',
          isUp: true,
          iconPath: 'order',
          bgColor: const Color(0xFFFFF4E5),
        ),
        DashboardStat(
          title: 'Total Sales',
          value: '\$89,000',
          change: '4.3% Down from yesterday',
          isUp: false,
          iconPath: 'sales',
          bgColor: const Color(0xFFE5F6EE),
        ),
        DashboardStat(
          title: 'Total Pending',
          value: '2040',
          change: '1.8% Up from yesterday',
          isUp: true,
          iconPath: 'pending',
          bgColor: const Color(0xFFFFE5E5),
        ),
      ];
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }
}