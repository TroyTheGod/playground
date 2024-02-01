import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playground/red_packet_rain/animation/red_packet_animation.dart';

class RedPacketRain extends StatefulWidget {
  const RedPacketRain({
    Key? key,
    required this.durationTime,
  }) : super(key: key);

  final int durationTime;

  @override
  State<RedPacketRain> createState() => _RedPacketRainState();
}

class _RedPacketRainState extends State<RedPacketRain> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  _init() async {
    Future.delayed(Duration(seconds: widget.durationTime), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: RedPacketAnimation(
          canvasWidth: MediaQuery.of(context).size.width,
          canvasHeight: MediaQuery.of(context).size.height,
          orientation: orientation,
        ),
      );
    });
  }
}
