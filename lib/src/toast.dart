import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idkit_toast/idkit_toast.dart';

class ToastView {
  /// Record the number of displays
  static List<dynamic> _marks;
  Timer _timer;
  double _isloading;
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

  /// Auto disappear of toast
  void toastAutoDismiss(BuildContext context, Widget child,
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
                      child: child,
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
    _marks.add(true);
    _timer = Timer(duration, () async {
      _isShow = 0.0;
      _overlayEntry.markNeedsBuild();
      await Future.delayed(Duration(milliseconds: 300), () {
        immediatelyDismiss();
      });
    });
  }

  void toastLoading(BuildContext context, Widget child,
      {String markId, ToastStyle style}) {
    _timer?.cancel();
    _timer = null;
    if (!_marks.contains(markId)) {
      _marks = [];
      _overlayEntry?.remove();
      _overlayEntry = null;
      // build
      _isloading = 1.0;
      _overlayEntry = OverlayEntry(builder: (context) {
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
                    opacity: _isloading,
                    child: Card(
                      shape: style.shape,
                      margin: style.margin,
                      color: style.bgColor,
                      child: Padding(
                        padding: style.padding,
                        child: child,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
      Overlay.of(context).insert(_overlayEntry);
    } else {
      child = null;
    }
    _marks.add(markId);
  }

  /// Remove toast
  void dismiss({String markId}) async {
    if (_marks.isNotEmpty) {
      if (markId != null && _marks.contains(markId)) {
        _marks.remove(markId);
      } else {
        _marks.removeLast();
      }
      // Is it empty of marks
      if (_marks.isEmpty) {
        _isloading = 0.0;
        _overlayEntry.markNeedsBuild();
        await Future.delayed(Duration(milliseconds: 300), () {
          _overlayEntry?.remove();
          _overlayEntry = null;
        });
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
