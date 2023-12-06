import 'package:flutter/material.dart';

class Toast extends StatefulWidget {
  final String? message;
  final Widget? child;
  final Alignment alignment;
  final Duration duration;
  const Toast({
    Key? key,
    this.message,
    this.child,
    required this.alignment,
    required this.duration,
  }) : super(key: key);

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  final int _animationMilliseconds = 300;

  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationMilliseconds),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller,
      ),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(
            Duration(
              milliseconds:
                  widget.duration.inMilliseconds - _animationMilliseconds * 2,
            ),
          );
          if (mounted) {
            _controller.reverse();
          }
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.alignment,
      padding: const EdgeInsets.symmetric(
        vertical: 85 + 12,
      ),
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0.0, 4.0),
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.15),
              )
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            child: widget.message == null
                ? widget.child
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xD97077A4),
                    ),
                    child: Text(
                      widget.message!,
                      style: TextStyle(
                        fontSize: widget.alignment == Alignment.bottomCenter
                            ? 16.0
                            : 14.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: widget.alignment == Alignment.bottomCenter
                            ? 1.24
                            : (20.0 / 14.0),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
