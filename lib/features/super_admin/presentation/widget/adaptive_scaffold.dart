import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/common_sidebar.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/common_topbar.dart';

class AdaptiveScaffold extends StatelessWidget {
  final String title;
  final bool showBreadcrumbIcon;

  final Widget mobileBody;
  final Widget tabletBody;
  final Widget? webBody;

  const AdaptiveScaffold({
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
      return Scaffold(
        backgroundColor: ColorConstants.darkWhiteColor,
        body: mobileBody,
      );
    }

    if (w < 1024) {
      return Scaffold(
        backgroundColor: ColorConstants.darkWhiteColor,
        body: Row(
          children: [
            CollapsedSidebar(),

            Expanded(
              child: Column(
                children: [
                  CommonTopBar(
                    title: title,
                    showBreadcrumbIcon: showBreadcrumbIcon,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageConstants.webBg),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: tabletBody,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.darkWhiteColor,
      body: Row(
        children: [
          FullSidebar(),

          Expanded(
            child: Column(
              children: [
                CommonTopBar(
                  title: title,
                  showBreadcrumbIcon: showBreadcrumbIcon,
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageConstants.webBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: webBody ?? tabletBody,
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