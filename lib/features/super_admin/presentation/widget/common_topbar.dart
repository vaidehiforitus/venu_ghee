import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';

class CommonTopBar extends StatelessWidget {
  final String title;
  final bool showBreadcrumbIcon;

  const CommonTopBar({
    super.key,
    required this.title,
    this.showBreadcrumbIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        border: Border(
          bottom: BorderSide(color: ColorConstants.borderWhiteColor),
        ),
      ),
      child: Row(
        children: [
          TextWidget(
            text: title,
            fontSize: adaptiveFont(context, 24/*showBreadcrumbIcon ? 16 : 24*/),
            fontWeight: FontWeight.w500,
            color: ColorConstants.textColor,
          ),

          const Spacer(),

          _TopBarIconBtn(icon: Icons.dark_mode_outlined),
          10.0.width,

          _TopBarIconBtn(icon: Icons.notifications_none_outlined),
          10.0.width,

          Container(
            padding:
            const EdgeInsets.only(left: 4, right: 10, top: 4, bottom: 4),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.borderWhiteColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: ColorConstants.redColor,
                  child: const Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                8.0.width,
                TextWidget(
                  text: 'Admin',
                  fontSize: adaptiveFont(context, 13),
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textColor,
                ),
                4.0.width,
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: ColorConstants.lightTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _TopBarIconBtn extends StatelessWidget {
  final IconData icon;
  const _TopBarIconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorConstants.borderWhiteColor),
        color: ColorConstants.primaryColor,
      ),
      child: Icon(icon, size: 17, color: ColorConstants.lightTextColor),
    );
  }
}