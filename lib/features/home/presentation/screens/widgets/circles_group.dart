import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CirclesGroup extends StatefulWidget {
  const CirclesGroup({super.key});

  @override
  State<CirclesGroup> createState() => _CirclesGroupState();
}

class _CirclesGroupState extends State<CirclesGroup>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 15),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: LottieBuilder.asset(
        'assets/lottie/main.json',
        controller: _animation,
        fit: BoxFit.cover,
      ),
    );
    // return ScaleTransition(
    //   scale: _animation,
    //   child: SizedBox(
    //     height: 200,
    //     width: 200,
    //     child: DecoratedBox(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         border: Border.all(
    //           color: Colors.black,
    //           width: 2,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
