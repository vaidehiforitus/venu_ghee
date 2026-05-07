import 'package:venu_ghee/core/utils/exports/common_exports.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstants.bgImage,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Dashboard',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.redColor,
                  ),
                  // TODO: Dashboard content
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}