import 'package:flutter/material.dart';

class PopScopeWidget extends StatelessWidget {
  final Widget child;
  final bool canPop;
  final void Function(bool didPop)? onPopInvoked;

  const PopScopeWidget({
    super.key,
    required this.child,
    this.canPop = false, // default: disable back
    this.onPopInvoked,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: onPopInvoked ?? (didPop) {
        if (didPop) return;
        // default: do nothing (prevent back)
      },
      child: child,
    );
  }
}
