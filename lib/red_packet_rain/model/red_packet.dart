import 'dart:math';

import 'package:flutter/material.dart';

class RedPacket {
  // red packet x position
  double x;
  // red packet x movement direction
  int? xDirection;
  // red packet y position
  double y;
  // red packet mass for gravity
  double m;
  int? xRotateDirection;
  int? yRotateDirection;
  int? zRotateDirection;
  double? xRotateSpeed;
  double? yRotateSpeed;
  double? zRotateSpeed;
  // red packet opacity
  double? opacity;
  // red packet fade in speed
  double? fadeInSpeed;
  // red packet filter opacity sign control
  // + mean increase, - mean decrease
  int? filterOpacitySignControl;
  // red packet filter opacity
  // (used to simulate the red packet light reflection)
  double? filterOpacity;
  // red packet rotation matrix
  Matrix4? matrix;
  // red packet delay time
  // need to wait for the red packet to be created
  int? delayDuration;
  // red packet life start time
  int? lifeStartTime;

  RedPacket({
    required this.x,
    this.xDirection,
    required this.y,
    required this.m,
    this.xRotateDirection,
    this.yRotateDirection,
    this.zRotateDirection,
    this.xRotateSpeed,
    this.yRotateSpeed,
    this.zRotateSpeed,
    this.matrix,
    this.opacity = 0,
    this.fadeInSpeed,
    this.filterOpacitySignControl,
    this.filterOpacity,
    this.delayDuration,
    this.lifeStartTime,
  }) {
    Random rnd = Random();
    xDirection ??= rnd.nextBool() ? 1 : -1;
    xRotateDirection ??= rnd.nextBool() ? 1 : -1;
    yRotateDirection ??= rnd.nextBool() ? 1 : -1;
    zRotateDirection ??= rnd.nextBool() ? 1 : -1;
    xRotateSpeed ??= rnd.nextDouble() * 0.02;
    yRotateSpeed ??= rnd.nextDouble() * 0.02;
    zRotateSpeed ??= rnd.nextDouble() * 0.02;
    fadeInSpeed ??= rnd.nextInt(3) / 100;
    filterOpacitySignControl ??= rnd.nextBool() ? 1 : -1;
    filterOpacity ??= rnd.nextInt(30) / 100;
    delayDuration ??= DateTime.now().millisecondsSinceEpoch +
        rnd.nextInt(1000) * rnd.nextInt(10);
    matrix ??= Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(xRotateDirection! * xRotateSpeed! * rnd.nextInt(100))
      ..rotateY(yRotateDirection! * yRotateSpeed! * rnd.nextInt(100))
      ..rotateZ(zRotateDirection! * zRotateSpeed! * rnd.nextInt(100));
  }

  factory RedPacket.fromCanvasSize(double canvasWidth, double canvasHeight) {
    Random rnd = Random();

    return RedPacket(
      x: rnd.nextDouble() * canvasWidth,
      y: (rnd.nextBool() ? -1 : -1) *
          rnd.nextInt((canvasHeight * 0.2).floor()).toDouble(),
      m: rnd.nextDouble() + rnd.nextDouble(),
    );
  }
}
