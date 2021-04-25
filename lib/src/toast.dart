import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idkit_toast/idkit_toast.dart';

class ToastView {
  /// The mark is toast.
  static String loadingMark = "com.loading.toast";

  /// Record the number of displays.
  List<dynamic> _marks;

  /// Auto destroy timer.
  Timer _timer;

  /// The state of toast.
  bool _loading = false;

  /// Animation monitoring object.
  StreamController<double> _streamController;

  /// The duration is destroy of toast.
  static Duration destroyDuration = Duration(milliseconds: 500);

  /// The layer of toasview.
  OverlayEntry _overlayEntry;

  /// Simple interest initialization.
  static ToastView _instance;
  factory ToastView() => _getInstance();
  static ToastView _getInstance() {
    if (_instance == null) {
      _instance = ToastView._init();
    }
    return _instance;
  }

  // init
  ToastView._init() {
    _marks = [];
    _streamController = StreamController<double>.broadcast();
  }

  /// Auto disappear of toast.
  void toastAutoDismiss(BuildContext context, Widget child,
      {ToastStyle style, Duration duration}) {
    if (_loading) return;
    _buildOverlayEntry(context, child, style);
    _timer = Timer(duration, () {
      _streamController.add(0.0);
      _timer?.cancel();
      _timer = null;
    });
  }

  /// loading of toast.
  void toastLoading(BuildContext context, Widget child, {ToastStyle style}) {
    if (_loading) {
      _marks.add(loadingMark);
      return;
    }
    _buildOverlayEntry(context, child, style);
    _marks.add(loadingMark);
  }

  /// OverlayEntry build.
  void _buildOverlayEntry(
      BuildContext context, Widget child, ToastStyle style) {
    _overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        color: style.maskColor,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: mappingAxisAlignment(style.alignment),
            children: [
              Flexible(
                child: StreamBuilder<double>(
                  stream: _streamController.stream,
                  initialData: 1.0,
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    return AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: data,
                      child: Card(
                        shape: style.shape,
                        margin: style.margin,
                        color: style.bgColor,
                        child: Padding(
                          padding: style.padding,
                          child: child,
                        ),
                      ),
                      onEnd: () {
                        if (data == 0.0) {
                          _loading = false;
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
    Overlay.of(context).insert(_overlayEntry);
    _loading = true;
  }

  /// Remove toast
  void dismiss() {
    if (_marks.isNotEmpty) {
      _marks.removeLast();
      if (_marks.isEmpty) {
        _streamController.add(0.0);
      }
    }
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
