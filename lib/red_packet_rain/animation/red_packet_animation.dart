import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

import '../model/red_packet.dart';

class RedPacketAnimation extends StatefulWidget {
  final double canvasWidth;
  final double canvasHeight;
  final Orientation orientation;

  const RedPacketAnimation({
    Key? key,
    required this.canvasHeight,
    required this.canvasWidth,
    required this.orientation,
  }) : super(key: key);

  @override
  State<RedPacketAnimation> createState() => _RedPacketAnimationState();
}

class _RedPacketAnimationState extends State<RedPacketAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  List<RedPacket> redPackets = [];

  int totalParticle = 0;
  final String imagePath = 'assets/images/red_packet_mini.png';
  final double speed = 1;

  ui.Image? _image;
  late int initTime;

  @override
  void initState() {
    super.initState();
    init();
    totalParticle = widget.orientation == Orientation.portrait ? 80 : 320;
  }

  void init() async {
    initTime = DateTime.now().millisecondsSinceEpoch;

    // setup animation
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    // setup image
    await _loadImage();

    // setup redPacket
    _initParticle();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  void _initParticle() {
    redPackets = [];
    for (var i = 0; i < totalParticle; i++) {
      redPackets.add(
        RedPacket.fromCanvasSize(widget.canvasWidth, widget.canvasHeight),
      );
    }
  }

  Future<void> _loadImage() async {
    var bytes = await rootBundle.load(imagePath);
    _image = await decodeImageFromList(bytes.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    // TODO widget.orientation to get the status of device orientation
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.canvasWidth,
        maxHeight: widget.canvasHeight,
      ),
      child: Stack(
        children: [
          for (int index = 0; index < redPackets.length; index++)
            CustomPaint(
              painter: RedPacketPainter(
                isDarkMode: false,
                redPacket: redPackets[index],
                redPackets: redPackets,
                canvasWidth: widget.canvasWidth,
                canvasHeight: widget.canvasHeight,
                index: index,
                image: _image,
                width: widget.canvasWidth,
                height: widget.canvasHeight,
                orientation: widget.orientation,
                currentTime: DateTime.now().millisecondsSinceEpoch,
              ),
              size: Size(
                _image!.width.toDouble(),
                _image!.height.toDouble(),
              ),
            )
        ],
      ),
    );
  }
}

class RedPacketPainter extends CustomPainter {
  final bool isDarkMode;
  ui.Image? image;
  RedPacket redPacket;
  List<RedPacket> redPackets;
  int index;
  int currentTime;
  double width;
  double height;
  double canvasWidth;
  double canvasHeight;
  Orientation orientation;

  RedPacketPainter({
    required this.isDarkMode,
    this.image,
    required this.redPacket,
    required this.redPackets,
    required this.index,
    required this.currentTime,
    required this.width,
    required this.height,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.orientation,
  });

  final Random _rnd = Random();

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) return;
    Paint paint = Paint();

    if (redPacket.delayDuration != null &&
        currentTime < redPacket.delayDuration!) {
      return;
    }

    // update life start time
    redPacket.lifeStartTime ??= DateTime.now().millisecondsSinceEpoch;

    if (!(redPacket.y > height + image!.height / 2)) {
      // update y
      final ySimulation = GravitySimulation(
        0.5 + _rnd.nextDouble(), // acceleration, pixels per second per second
        0.0, // starting position, pixels
        height + image!.height * _rnd.nextDouble(), // ending position, pixels
        1, // starting velocity, pixels per second
      );

      redPacket.y += ySimulation.x(
        _normalizeTime(
              currentTime,
              redPacket.lifeStartTime!,
            ) +
            1,
      );

      // update x
      redPacket.x += redPacket.xDirection! * _rnd.nextDouble();

      // fade in
      if (redPacket.opacity! < 1) {
        if (redPacket.opacity! + redPacket.fadeInSpeed! > 1) {
          redPacket.opacity = 1;
        } else {
          redPacket.opacity = redPacket.opacity! + redPacket.fadeInSpeed!;
        }
      }

      paint.color = Color.fromRGBO(
        0,
        0,
        0,
        redPacket.opacity!,
      );

      // update rotation
      Matrix4 matrix = redPacket.matrix!;
      matrix
        ..rotateX(redPacket.xRotateSpeed! * redPacket.xRotateDirection!)
        ..rotateY(redPacket.yRotateSpeed! * redPacket.yRotateDirection!)
        ..rotateZ(redPacket.zRotateSpeed! * redPacket.zRotateDirection!);

      // update position before rotation
      canvas.translate(
        image!.width / 2 + redPacket.x,
        image!.height / 2 + redPacket.y,
      );
      canvas.transform(matrix.storage);

      if (orientation == Orientation.portrait) {
        canvas.scale(0.8);
      } else {
        canvas.scale(0.5);
      }

      canvas.drawImage(
        image!,
        Offset(-image!.width / 2, -image!.height / 2),
        paint,
      );
      canvas.translate(-image!.width / 2, -image!.height / 2);

      // add refection
      if (redPacket.opacity! > 0.9) {
        canvas.save();
        if (redPacket.filterOpacity! < 0.4 &&
            redPacket.filterOpacitySignControl == 1) {
          redPacket.filterOpacity = redPacket.filterOpacity! + 0.01;
        } else {
          if (redPacket.filterOpacity! - 0.01 < 0) {
            redPacket.filterOpacity = 0;
            redPacket.filterOpacitySignControl = 1;
          } else {
            redPacket.filterOpacity = redPacket.filterOpacity! - 0.01;
            redPacket.filterOpacitySignControl = -1;
          }
        }

        canvas.drawRect(
          Rect.fromPoints(
            const Offset(0, 0),
            Offset(
              image!.width.toDouble(),
              image!.height.toDouble(),
            ),
          ),
          Paint()
            ..color = Colors.white.withOpacity(
              isDarkMode
                  ? redPacket.filterOpacity! * 0.7
                  : redPacket.filterOpacity!,
            ),
        );
        canvas.restore();
      }

      redPacket.matrix = matrix;
      redPackets[index] = redPacket;
    } else {
      redPacket = RedPacket.fromCanvasSize(canvasWidth, canvasHeight);
      redPackets[index] = redPacket;
    }
  }

  double _normalizeTime(int ms, int lifeStartTime) =>
      (ms - lifeStartTime) / Duration.millisecondsPerSecond;

  @override
  bool shouldRepaint(RedPacketPainter oldDelegate) => true;
}
