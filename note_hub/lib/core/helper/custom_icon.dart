import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final String path;
  final double? size;
  final Color? color;

  const CustomIcon({super.key, required this.path, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        path,
        color: color,
        height: size,
        width: size,
        fit: BoxFit.contain,
      ),
    );
  }
}

class CustomAvatar extends StatelessWidget {
  final String path;
  final double? radius;
  const CustomAvatar({super.key, required this.path, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(path),
    );
  }
}
