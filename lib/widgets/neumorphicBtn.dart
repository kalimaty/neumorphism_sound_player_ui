import 'package:flutter/material.dart';

import '../constants/app_color.dart';

// ignore: must_be_immutable
class NeumorphicBtn extends StatelessWidget {
  NeumorphicBtn({
    super.key,
    this.child,
    required this.size,
    this.blur = 20,
    this.distance = 10,
    this.colors,
    this.onPressed,
    this.imageUrl,
    this.padding,
  });
  final Widget? child;
  final double size;
  final double blur;
  final double distance;
  List<Color>? colors;
  final VoidCallback? onPressed;
  final String? imageUrl;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding ?? 3),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colors == null ? AppColor.bgColor : colors![1],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(
                -distance,
                -distance,
              ),
              color: AppColor.white,
              blurRadius: blur,
            ),
            BoxShadow(
              offset: Offset(
                distance,
                distance,
              ),
              color: AppColor.bgDark,
              blurRadius: blur,
            ),
          ],
        ),
        child: imageUrl != null
            ? CircleAvatar(
                backgroundImage: AssetImage(imageUrl!),
              )
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.bgColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors ??
                        [
                          AppColor.white,
                          AppColor.bgDark,
                        ],
                  ),
                ),
                child: child,
              ),
      ),
    );
  }
}
