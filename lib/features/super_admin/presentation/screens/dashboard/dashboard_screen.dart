import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

class _StatData {
  final String title;
  final String value;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String trend;
  final bool isUp;

  const _StatData({
    required this.title,
    required this.value,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.trend,
    required this.isUp,
  });
}

const List<_StatData> _stats = [
  _StatData(
    title: 'Total User',
    value: '40,689',
    icon: Icons.people_outline,
    bgColor: Color(0xFFEDE7F6),
    iconColor: Color(0xFF7C3AED),
    trend: '8.5% Up from yesterday',
    isUp: true,
  ),
  _StatData(
    title: 'Total Order',
    value: '10293',
    icon: Icons.inventory_2_outlined,
    bgColor: Color(0xFFFFF8E1),
    iconColor: Color(0xFFF59E0B),
    trend: '1.3% Up from past week',
    isUp: true,
  ),
  _StatData(
    title: 'Total Sales',
    value: '\$89,000',
    icon: Icons.show_chart,
    bgColor: Color(0xFFE8F5E9),
    iconColor: Color(0xFF10B981),
    trend: '4.3% Down from yesterday',
    isUp: false,
  ),
  _StatData(
    title: 'Total Pending',
    value: '2040',
    icon: Icons.timer_outlined,
    bgColor: Color(0xFFFFF3E0),
    iconColor: Color(0xFFFF6B6B),
    trend: '1.8% Up from yesterday',
    isUp: true,
  ),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: 'Dashboard',
      // showBreadcrumbIcon: false, // Dashboard top bar ma icon nathi
      mobileBody: const _MobileDashboardBody(),
      tabletBody: const _DesktopDashboardBody(crossAxisCount: 2),
      webBody: const _DesktopDashboardBody(crossAxisCount: 4),
    );
  }
}

class _MobileDashboardBody extends StatelessWidget {
  const _MobileDashboardBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Dashboard',
              fontSize: adaptiveFont(context, 20),
              fontWeight: FontWeight.w700,
              color: ColorConstants.redColor,
            ),
            20.0.height,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: _stats.map((s) => _StatCard(data: s)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopDashboardBody extends StatelessWidget {
  final int crossAxisCount;

  const _DesktopDashboardBody({required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget(
                text: 'Hello, Admin!',
                fontSize: adaptiveFont(context, 24),
                fontWeight: FontWeight.w700,
                color: ColorConstants.textColor,
              ),
              const Spacer(),
              _FilterBtn(
                label: 'Sort by: Due Date',
                icon: Icons.keyboard_arrow_down,
              ),
              8.0.width,
              _FilterBtn(
                label: 'Filter',
                icon: Icons.tune_outlined,
                iconFirst: true,
              ),
            ],
          ),
          20.0.height,

          if (crossAxisCount == 4)
            Row(
              children: _stats.asMap().entries.map((entry) {
                final isLast = entry.key == _stats.length - 1;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : 12),
                    child: _StatCard(data: entry.value),
                  ),
                );
              }).toList(),
            )
          else
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.8,
                children: _stats.map((s) => _StatCard(data: s)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(12),
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
                  text: data.title,
                  fontSize: adaptiveFont(context, 12),
                  color: ColorConstants.lightTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: data.bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  data.icon,
                  size: adaptiveFont(context, 16),
                  color: data.iconColor,
                ),
              ),
            ],
          ),
          TextWidget(
            text: data.value,
            fontSize: adaptiveFont(context, 20),
            fontWeight: FontWeight.w700,
            color: ColorConstants.textColor,
          ),
          Row(
            children: [
              Icon(
                data.isUp ? Icons.trending_up : Icons.trending_down,
                size: 14,
                color: data.isUp ? Colors.green : Colors.red,
              ),
              4.0.width,
              Flexible(
                child: TextWidget(
                  text: data.trend,
                  fontSize: adaptiveFont(context, 10),
                  color: ColorConstants.lightTextColor,
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
}

class _FilterBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool iconFirst;

  const _FilterBtn({
    required this.label,
    required this.icon,
    this.iconFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(
      icon,
      size: 14,
      color: ColorConstants.lightTextColor,
    );
    final textWidget = TextWidget(
      text: label,
      fontSize: adaptiveFont(context, 12),
      fontWeight: FontWeight.w500,
      color: ColorConstants.textColor,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        border: Border.all(color: ColorConstants.borderWhiteColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconFirst
            ? [iconWidget, 6.0.width, textWidget]
            : [textWidget, 6.0.width, iconWidget],
      ),
    );
  }
}