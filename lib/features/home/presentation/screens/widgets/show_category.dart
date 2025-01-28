import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';

class ShowCategory extends StatelessWidget {
  final String category;
  final bool active;
  const ShowCategory({
    super.key,
    required this.category,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height64,
      width: Dimensions.width90,
      margin: EdgeInsets.only(right: Dimensions.width10),
      decoration: BoxDecoration(
        color: active ? AppColors.secondColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(
          Dimensions.radius15,
        ),
      ),
      child: Center(
        child: Text("$category"),
      ),
    );
  }
}
