import 'dart:math';

import 'package:flutter/material.dart';

class EatWhatHo extends StatefulWidget {
  const EatWhatHo({Key? key}) : super(key: key);

  @override
  State<EatWhatHo> createState() => _EatWhatHoState();
}

class _EatWhatHoState extends State<EatWhatHo> {
  double rotate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final randomSeed1 = Random().nextInt(9999999);
          final randomSeed2 = Random().nextInt(9999999);
          final random1 = Random(randomSeed1).nextInt(40);
          final random2 = Random(randomSeed2).nextInt(40);
          setState(() {
            rotate = (random1 + random2) * 0.25;
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '烤肉拌饭',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  '大东北',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            const Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  '满炖',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '口水鸡',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Center(
                  child: AnimatedRotation(
                curve: Curves.easeInOutCubic,
                duration: const Duration(seconds: 10),
                turns: rotate,
                child: const Text(
                  '↑',
                  style: TextStyle(fontSize: 90.0),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
