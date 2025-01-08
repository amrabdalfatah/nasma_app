import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/features/home/presentation/screens/home_view.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/circles_group.dart';

class BreathingSessionView extends StatefulWidget {
  final int cycle;
  final String level;
  const BreathingSessionView({
    super.key,
    required this.cycle,
    required this.level,
  });

  @override
  State<BreathingSessionView> createState() => _BreathingSessionViewState();
}

class _BreathingSessionViewState extends State<BreathingSessionView> {
  int sec = 5;
  bool start = false;
  late int cyc;

  @override
  void initState() {
    cyc = widget.cycle;
    super.initState();
  }

  void decreaseSecond(int cycle) {
    if (cycle != 0) {
      start = true;
      Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          if (sec > 1) {
            setState(() {
              sec--;
            });
          } else {
            setState(() {
              sec = 5;
              --cyc;
            });
            decreaseSecond(cycle - 1);

            timer.cancel();
          }
        },
      );
    } else {
      setState(() {
        start = false;
      });
      Get.offAll(() => HomeView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.level} Breathing Session'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Container(
                  //   height: 200,
                  //   width: 200,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //       color: Colors.black,
                  //       width: 3,
                  //     ),
                  //   ),
                  // ),
                  if (start) CirclesGroup(),
                  if (!start)
                    BigText(
                      text: 'Let\'s Take a session',
                      color: Colors.black,
                      size: Dimensions.font20,
                    ),
                  // BigText(
                  //   text: '$sec',
                  //   color: start ? Colors.white : Colors.black,
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.height64,
              horizontal: Dimensions.height100,
            ),
            child: MainButton(
              text: start ? 'Breathing ($cyc)' : 'Start',
              onTap: start
                  ? null
                  : () {
                      decreaseSecond(widget.cycle);
                    },
            ),
          ),
        ],
      ),
    );
  }
}
