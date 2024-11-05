import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:notehub/core/config/color.dart';

class RefresherWidget extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const RefresherWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: onRefresh,
      backgroundColor: OtherColors.amethystPurple,
      showChildOpacityTransition: false,
      color: GrayscaleWhiteColors.white,
      borderWidth: 2,
      animSpeedFactor: 10,
      height: 70,
      child: child,
    );
  }
}
