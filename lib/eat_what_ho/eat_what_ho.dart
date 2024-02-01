import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EatWhatHo extends StatefulWidget {
  final int? spinnerType;
  const EatWhatHo({
    Key? key,
    this.spinnerType,
  }) : super(key: key);

  @override
  State<EatWhatHo> createState() => _EatWhatHoState();
}

class _EatWhatHoState extends State<EatWhatHo> {
  double rotate = 0;
  PageController? pageController;
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  final foodList = [
    '烤肉拌饭',
    '大东北',
    '满炖',
    '口水鸡',
  ];
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.spinnerType ?? 0);
  }

  @override
  void dispose() {
    pageController?.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: pageController,
        children: [
          GestureDetector(
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
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      foodList[0],
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      foodList[1],
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      foodList[2],
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      foodList[3],
                      style: const TextStyle(fontSize: 30.0),
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
          GestureDetector(
            onTap: () {
              final randomSeed1 = Random().nextInt(9999999);
              final randomSeed2 = Random().nextInt(9999999);
              final random1 = Random(randomSeed1).nextInt(120);
              final random2 = Random(randomSeed2).nextInt(120);
              scrollController.animateToItem(
                random1 + random2,
                duration: const Duration(seconds: 5),
                curve: Curves.easeInOut,
              );
            },
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                height: 300.0,
                child: CupertinoPicker(
                  scrollController: scrollController,
                  itemExtent: 30.0,
                  looping: true,
                  magnification: 1.2,
                  useMagnifier: true,
                  onSelectedItemChanged: (value) {},
                  children: [
                    for (final food in foodList) Text(food),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
