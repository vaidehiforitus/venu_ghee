
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_common_sidebar.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/common_topbar.dart';

class BranchAdaptiveScaffold extends StatelessWidget {
  final String title;
  final bool showBreadcrumbIcon;
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget? webBody;

  const BranchAdaptiveScaffold({
    super.key,
    required this.title,
    required this.mobileBody,
    required this.tabletBody,
    this.webBody,
    this.showBreadcrumbIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    if (w < 600) {
      return mobileBody;
    }

    // TABLET (600 – 1023)
    if (w < 1024) {
      return Scaffold(
        backgroundColor: ColorConstants.darkWhiteColor,
        body: Row(
          children: [
            BranchCollapsedSidebar(),
            Expanded(
              child: Column(
                children: [
                  CommonTopBar(
                    title: title,
                    showBreadcrumbIcon: showBreadcrumbIcon,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            ImageConstants.webBg,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Content
                        tabletBody,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // ── WEB (≥ 1024)
    return Scaffold(
      backgroundColor: ColorConstants.darkWhiteColor,
      body: Row(
        children: [
          BranchFullSidebar(),
          Expanded(
            child: Column(
              children: [
                CommonTopBar(
                  title: title,
                  showBreadcrumbIcon: showBreadcrumbIcon,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          ImageConstants.webBg,
                          fit: BoxFit.cover,
                        ),
                      ),
                      webBody ?? tabletBody,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}