import 'package:flutter/material.dart';
import 'package:playground/overlay/widget/toast.dart';

OverlayEntry? popUpMessageOverlayEntry;

class CustomPopUpOverlay {
  // singleton approach
  CustomPopUpOverlay._();
  static CustomPopUpOverlay? _instance;
  factory CustomPopUpOverlay() => _instance ?? CustomPopUpOverlay._();

  /// [child] 和 [message] 填其中一个，不能两个都填
  Future<void> showToast(
    BuildContext context, {
    String? message,
    Widget? child,
    Duration toastDuration = const Duration(seconds: 3),
  }) async {
    assert(message != null || child != null,
        throw 'either message or child is required');
    assert(!(message != null && child != null),
        throw 'message and child cannot be passed in at the same time');

    if (popUpMessageOverlayEntry != null) {
      popUpMessageOverlayEntry?.remove();
      popUpMessageOverlayEntry = null;
    }
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Toast(
          message: message,
          alignment: Alignment.bottomCenter,
          duration: toastDuration,
          child: child,
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);

    popUpMessageOverlayEntry = overlayEntry;
    await Future.delayed(toastDuration);
    if (popUpMessageOverlayEntry == overlayEntry) {
      popUpMessageOverlayEntry?.remove();
      popUpMessageOverlayEntry = null;
    }
  }
}
