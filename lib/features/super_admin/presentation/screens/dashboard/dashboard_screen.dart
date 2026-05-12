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
                childAspectRatio: 1.55,
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
              children: _stats.map((s) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: s == _stats.last ? 0 : 16),
                    child: _StatCard(data: s),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: TextWidget(
                  text: data.title,
                  fontSize: adaptiveFont(context, 16),
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.lightTextColor,
                ),
              ),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: data.bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(data.icon, color: data.iconColor, size: 18),
              ),
            ],
          ),
          TextWidget(
            text: data.value,
            fontSize: adaptiveFont(context, 28),
            fontWeight: FontWeight.w700,
            color: ColorConstants.textColor,
          ),
          20.0.height,
          Row(
            children: [
              Icon(
                data.isUp ? Icons.trending_up : Icons.trending_down,
                size: 16,
                color: data.isUp ? Colors.green : Colors.red,
              ),
              6.0.width,
              Expanded(
                child: TextWidget(
                  text: data.trend,
                  fontSize: adaptiveFont(context, 16),
                  color: ColorConstants.lightTextColor,
                  maxLines: 2,
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


// import 'package:get/get.dart';
// import 'package:venu_ghee/core/utils/exports/common_exports.dart';
// import 'package:venu_ghee/features/super_admin/presentation/widget/bottom_navigation_bar_widget.dart';
//
// double adaptiveFont(BuildContext context, double size) {
//   final w = MediaQuery.of(context).size.width;
//   if (w < 600) return size;
//   if (w < 1024) return size * 0.90;
//   return size * 0.80;
// }
//
// class _StatData {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color bgColor;
//   final Color iconColor;
//   final String trend;
//   final bool isUp;
//
//   const _StatData({
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.bgColor,
//     required this.iconColor,
//     required this.trend,
//     required this.isUp,
//   });
// }
//
// const List<_StatData> _stats = [
//   _StatData(
//     title: 'Total User',
//     value: '40,689',
//     icon: Icons.people_outline,
//     bgColor: Color(0xFFEDE7F6),
//     iconColor: Color(0xFF7C3AED),
//     trend: '8.5% Up from yesterday',
//     isUp: true,
//   ),
//   _StatData(
//     title: 'Total Order',
//     value: '10293',
//     icon: Icons.inventory_2_outlined,
//     bgColor: Color(0xFFFFF8E1),
//     iconColor: Color(0xFFF59E0B),
//     trend: '1.3% Up from past week',
//     isUp: true,
//   ),
//   _StatData(
//     title: 'Total Sales',
//     value: '\$89,000',
//     icon: Icons.show_chart,
//     bgColor: Color(0xFFE8F5E9),
//     iconColor: Color(0xFF10B981),
//     trend: '4.3% Down from yesterday',
//     isUp: false,
//   ),
//   _StatData(
//     title: 'Total Pending',
//     value: '2040',
//     icon: Icons.timer_outlined,
//     bgColor: Color(0xFFFFF3E0),
//     iconColor: Color(0xFFFF6B6B),
//     trend: '1.8% Up from yesterday',
//     isUp: true,
//   ),
// ];
//
// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     if (w >= 1024) return const _WebDashboardLayout();
//     if (w >= 600) return const _TabletDashboardLayout();
//     return const _MobileDashboardLayout();
//   }
// }
//
// //  MOBILE LAYOUT
// class _MobileDashboardLayout extends StatelessWidget {
//   const _MobileDashboardLayout();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.darkWhiteColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextWidget(
//                 text: 'Dashboard',
//                 fontSize: adaptiveFont(context, 20),
//                 fontWeight: FontWeight.w700,
//                 color: ColorConstants.redColor,
//               ),
//               20.0.height,
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                   childAspectRatio: 1.55,
//                   children: _stats.map((s) => _StatCard(data: s)).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //  TABLET LAYOUT  (600–1023px)
// class _TabletDashboardLayout extends StatelessWidget {
//   const _TabletDashboardLayout();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.darkWhiteColor,
//       body: Row(
//         children: [
//           _CollapsedSidebar(),
//           Expanded(
//             child: Column(
//               children: [
//                 const _TopBar(),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const _HelloRow(),
//                         20.0.height,
//                         Expanded(
//                           child: GridView.count(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 16,
//                             mainAxisSpacing: 16,
//                             childAspectRatio: 2.8,
//                             children: _stats.map((s) => _StatCard(data: s)).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  WEB LAYOUT
// class _WebDashboardLayout extends StatelessWidget {
//   const _WebDashboardLayout();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.darkWhiteColor,
//       body: Row(
//         children: [
//           _FullSidebar(),
//           Expanded(
//             child: Column(
//               children: [
//                 const _TopBar(),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const _HelloRow(),
//                         20.0.height,
//                         Row(
//                           children: _stats.map((s) {
//                             return Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: s == _stats.last ? 0 : 16,
//                                 ),
//                                 child: _StatCard(data: s),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  COLLAPSED SIDEBAR
// class _CollapsedSidebar extends StatelessWidget {
//   final MainController controller = Get.find<MainController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 130,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         color: ColorConstants.primaryColor,
//         border: Border(
//           right: BorderSide(color: ColorConstants.borderWhiteColor),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Logo
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Image.asset(
//               ThemeHelper.logoImage(),
//               height: 50,
//               width: 50,
//               fit: BoxFit.contain,
//             ),
//           ),
//           8.0.height,
//           // Nav items — icon only
//           Obx(
//                 () => Column(
//               children: [
//                 _SidebarItem(
//                   icon: ImageConstants.dashboardIcon,
//                   index: 0,
//                   currentIndex: controller.currentIndex.value,
//                   onTap: () => controller.changeIndex(0),
//                 ),
//                 _SidebarItem(
//                   icon: ImageConstants.branchIcon,
//                   index: 1,
//                   currentIndex: controller.currentIndex.value,
//                   onTap: () => controller.changeIndex(1),
//                 ),
//                 _SidebarItem(
//                   icon: ImageConstants.productIcon,
//                   index: 2,
//                   currentIndex: controller.currentIndex.value,
//                   onTap: () => controller.changeIndex(2),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  FULL SIDEBAR
// class _FullSidebar extends StatelessWidget {
//   final MainController controller = Get.find<MainController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         color: ColorConstants.primaryColor,
//         border: Border(
//           right: BorderSide(color: ColorConstants.borderWhiteColor),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Logo
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Image.asset(
//               ThemeHelper.logoImage(),
//               height: 55,
//               fit: BoxFit.contain,
//             ),
//           ),
//           8.0.height,
//           // Nav items — icon + label
//           Obx(
//                 () => Column(
//               children: [
//                 _SidebarLabelItem(
//                   icon: ImageConstants.dashboardIcon,
//                   label: 'Dashboard',
//                   index: 0,
//                   currentIndex: controller.currentIndex.value,
//                   onTap: () => controller.changeIndex(0),
//                 ),
//                 _SidebarLabelItem(
//                   icon: ImageConstants.branchIcon,
//                   label: 'Branch',
//                   index: 1,
//                   currentIndex: controller.currentIndex.value,
//                   onTap: () => controller.changeIndex(1),
//                 ),
//                 _SidebarLabelItem(
//                   icon: ImageConstants.productIcon,
//                   label: 'Product',
//                   index: 2,
//                   currentIndex: controller.currentIndex.value,
//                   onTap: () => controller.changeIndex(2),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  SIDEBAR ITEM
// class _SidebarItem extends StatelessWidget {
//   final String icon;
//   final int index;
//   final int currentIndex;
//   final VoidCallback onTap;
//
//   const _SidebarItem({
//     required this.icon,
//     required this.index,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = index == currentIndex;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isSelected ? ColorConstants.redColor : Colors.transparent,
//           shape: BoxShape.circle,
//         ),
//         child: Image.asset(
//           icon,
//           height: 22,
//           width: 22,
//           color: isSelected
//               ? ColorConstants.primaryColor
//               : ColorConstants.silverGrayColor,
//         ),
//       ),
//     );
//   }
// }
//
// //  SIDEBAR LABEL
// class _SidebarLabelItem extends StatelessWidget {
//   final String icon;
//   final String label;
//   final int index;
//   final int currentIndex;
//   final VoidCallback onTap;
//
//   const _SidebarLabelItem({
//     required this.icon,
//     required this.label,
//     required this.index,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = index == currentIndex;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? ColorConstants.redColor : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           children: [
//             Image.asset(
//               icon,
//               height: 18,
//               width: 18,
//               color: isSelected
//                   ? ColorConstants.primaryColor
//                   : ColorConstants.silverGrayColor,
//             ),
//             8.0.width,
//             TextWidget(
//               text: label,
//               fontSize: adaptiveFont(context, 13),
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//               color: isSelected
//                   ? ColorConstants.primaryColor
//                   : ColorConstants.silverGrayColor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _TopBar extends StatelessWidget {
//   const _TopBar();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       decoration: BoxDecoration(
//         color: ColorConstants.primaryColor,
//         border: Border(
//           bottom: BorderSide(color: ColorConstants.borderWhiteColor),
//         ),
//       ),
//       child: Row(
//         children: [
//           TextWidget(
//             text: 'Dashboard',
//             fontSize: adaptiveFont(context, 24),
//             fontWeight: FontWeight.w500,
//             color: ColorConstants.textColor,
//           ),
//           const Spacer(),
//           _TopBarIconBtn(icon: Icons.dark_mode_outlined),
//           10.0.width,
//           _TopBarIconBtn(icon: Icons.notifications_none_outlined),
//           10.0.width,
//           // Admin pill
//           Container(
//             padding: const EdgeInsets.only(left: 4, right: 10, top: 4, bottom: 4),
//             decoration: BoxDecoration(
//               border: Border.all(color: ColorConstants.borderWhiteColor),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   radius: 13,
//                   backgroundColor: ColorConstants.redColor,
//                   child: const Text(
//                     'A',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 8.0.width,
//                 TextWidget(
//                   text: 'Admin',
//                   fontSize: adaptiveFont(context, 13),
//                   fontWeight: FontWeight.w500,
//                   color: ColorConstants.textColor,
//                 ),
//                 4.0.width,
//                 Icon(
//                   Icons.keyboard_arrow_down,
//                   size: 16,
//                   color: ColorConstants.lightTextColor,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _TopBarIconBtn extends StatelessWidget {
//   final IconData icon;
//   const _TopBarIconBtn({required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 34,
//       height: 34,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: ColorConstants.borderWhiteColor),
//         color: ColorConstants.primaryColor,
//       ),
//       child: Icon(icon, size: 17, color: ColorConstants.lightTextColor),
//     );
//   }
// }
//
// class _HelloRow extends StatelessWidget {
//   const _HelloRow();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         TextWidget(
//           text: 'Hello, Admin!',
//           fontSize: adaptiveFont(context, 24),
//           fontWeight: FontWeight.w700,
//           color: ColorConstants.textColor,
//         ),
//         const Spacer(),
//         _FilterBtn(
//           label: 'Sort by: Due Date',
//           icon: Icons.keyboard_arrow_down,
//         ),
//         8.0.width,
//         _FilterBtn(
//           label: 'Filter',
//           icon: Icons.tune_outlined,
//           iconFirst: true,
//         ),
//       ],
//     );
//   }
// }
//
// class _FilterBtn extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final bool iconFirst;
//
//   const _FilterBtn({
//     required this.label,
//     required this.icon,
//     this.iconFirst = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final iconWidget = Icon(icon, size: 14, color: ColorConstants.lightTextColor);
//     final textWidget = TextWidget(
//       text: label,
//       fontSize: adaptiveFont(context, 12),
//       fontWeight: FontWeight.w500,
//       color: ColorConstants.textColor,
//     );
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//       decoration: BoxDecoration(
//         color: ColorConstants.primaryColor,
//         border: Border.all(color: ColorConstants.borderWhiteColor),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: iconFirst
//             ? [iconWidget, 6.0.width, textWidget]
//             : [textWidget, 6.0.width, iconWidget],
//       ),
//     );
//   }
// }
//
// class _StatCard extends StatelessWidget {
//   final _StatData data;
//   const _StatCard({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: ColorConstants.primaryColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: ColorConstants.borderWhiteColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextWidget(
//                   text: data.title,
//                   fontSize: adaptiveFont(context, 16),
//                   fontWeight: FontWeight.w400,
//                   color: ColorConstants.lightTextColor,
//                 ),
//               ),
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: data.bgColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(data.icon, color: data.iconColor, size: 18),
//               ),
//             ],
//           ),
//           TextWidget(
//             text: data.value,
//             fontSize: adaptiveFont(context, 28),
//             fontWeight: FontWeight.w700,
//             color: ColorConstants.textColor,
//           ),
//           20.0.height,
//           Row(
//             children: [
//               Icon(
//                 data.isUp ? Icons.trending_up : Icons.trending_down,
//                 size: 16,
//                 color: data.isUp ? Colors.green : Colors.red,
//               ),
//               6.0.width,
//               Expanded(
//                 child: TextWidget(
//                   text: data.trend,
//                   fontSize: adaptiveFont(context, 16),
//                   color: ColorConstants.lightTextColor,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// lib/features/super_admin/presentation/screens/dashboard/dashboard_screen.dart
