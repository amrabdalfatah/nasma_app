import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/utils/images.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  const CustomAppBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimensions.height100,
      child: RotatedBox(
        quarterTurns: 15,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Images.bg,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: RotatedBox(
            quarterTurns: -15,
            child: child,
          ),
        ),
      ),
    );
  }
}
