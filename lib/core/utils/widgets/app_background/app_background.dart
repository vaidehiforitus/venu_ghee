import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venu_ghee/core/theme/theme_controller.dart';
import 'package:venu_ghee/core/theme/theme_helper.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      id: 'theme_icon',
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ThemeHelper.backgroundImage()),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        );
      },
    );
  }
}