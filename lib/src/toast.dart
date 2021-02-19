import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idkit_toast/idkit_toast.dart';

class ToastView {
  /// Record the number of displays
  static List<String> _marks;
  Timer _timer;
  OverlayEntry _overlayEntry;
  static ToastView _instance;
  factory ToastView() => _getInstance();
  static ToastView _getInstance() {
    if (_instance == null) {
      _instance = ToastView._init();
    }
    return _instance;
  }

  ToastView._init() {
    _marks = [];
  }

  /// There is only one text of toast
  void toastAutoDismiss(BuildContext context, Widget widget,
      {ToastStyle style, Duration duration}) {
    immediatelyDismiss();
    var _isShow = 1.0;
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: style.maskColor,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: mappingAxisAlignment(style.alignment),
              children: [
                Flexible(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: _isShow,
                    child: Card(
                      shape: style.shape,
                      margin: style.margin,
                      color: style.bgColor,
                      child: widget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry);
    _timer = Timer(duration, () async {
      _isShow = 0.0;
      _overlayEntry.markNeedsBuild();
      await Future.delayed(Duration(milliseconds: 300));
      immediatelyDismiss();
    });
  }

  /// Remove toast
  void dismiss() {
    if (_marks != null && _marks.length != 0) {
      _marks.removeLast();
      // Is it empty of marks
      if (_marks.isEmpty) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    }
  }

  /// Immediately remove toast
  void immediatelyDismiss() {
    if (_marks.isNotEmpty) {
      _marks = [];
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
    _timer?.cancel();
    _timer = null;
  }

  /// Toast Alignment mapping
  MainAxisAlignment mappingAxisAlignment(ToastAlignment alignment) {
    switch (alignment) {
      case ToastAlignment.top:
        return MainAxisAlignment.start;
        break;
      case ToastAlignment.bottom:
        return MainAxisAlignment.end;
        break;
      default:
        return MainAxisAlignment.center;
    }
  }
}
