import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';

class DataInput extends StatelessWidget {
  const DataInput({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height100,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: text,
            size: Dimensions.font20,
            color: Colors.black,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w600,
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
