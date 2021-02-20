part of idkit_toast;

class IDKitToast {
  /// There is only one text
  /// It will disappear in 5 seconds
  static showText(
    BuildContext context, {
    String content = "",
    ToastStyle style,
    Duration duration,
  }) {
    var _style = ToastStyle.mappingStyle(style);
    var _duration = duration ?? Duration(seconds: 5);
    var _widget = SingleChildScrollView(
      child: Padding(
        padding: _style.padding,
        child: Text(
          content,
          style: _style.textStyle,
        ),
      ),
    );
    ToastView()
        .toastAutoDismiss(context, _widget, style: _style, duration: _duration);
  }

  /// Rich text tosat
  /// It will disappear in 5 seconds
  static showRichText(
    BuildContext context,
    ImageProvider<Object> image, {
    String content = "",
    ToastStyle style,
    Duration duration,
    double space = 10,
    Size imageSize,
  }) {
    var _style = ToastStyle.mappingStyle(style);
    var _duration = duration ?? Duration(seconds: 5);
    var _children = content.isEmpty
        ? [
            Image(
              image: image,
              width: imageSize?.width,
              height: imageSize?.height,
            )
          ]
        : [
            Image(
              image: image,
              width: imageSize?.width,
              height: imageSize?.height,
            ),
            SizedBox(
              height: space,
            ),
            Text(
              content,
              style: _style.textStyle,
            ),
          ];
    var _widget = Padding(
      padding: _style.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
    );
    ToastView()
        .toastAutoDismiss(context, _widget, style: _style, duration: _duration);
  }

  /// Custom toast
  /// It will disappear in 5 seconds
  static showCustom(
    BuildContext context,
    Widget child, {
    ToastStyle style,
    Duration duration,
  }) {
    var _style = ToastStyle.mappingStyle(style);
    var _duration = duration ?? Duration(seconds: 5);
    ToastView()
        .toastAutoDismiss(context, child, style: _style, duration: _duration);
  }

  /// Rich activityIndicator or activityIndicator of Loading toast
  static loading(
    BuildContext context, {
    String markId,
    String content,
    ToastStyle style =
        const ToastStyle(padding: EdgeInsets.all(30), bgColor: Colors.grey),
    double space = 10,
  }) {
    var _style = ToastStyle.mappingStyle(style);
    var _child1 = CupertinoActivityIndicator(
      radius: 20,
    );
    var _child;
    if (content != null && content.isNotEmpty) {
      _child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _child1,
          SizedBox(
            height: space,
          ),
          Text(
            content,
            style: _style.textStyle,
          ),
        ],
      );
    } else {
      _child = _child1;
    }
    ToastView()
        .toastLoading(context, _child, style: _style, markId: markId ?? "");
  }

  /// Custom loading of toast
  static loadingCustom(BuildContext context, Widget child,
      {ToastStyle style, String markId}) {
    var _style = ToastStyle.mappingStyle(style);
    ToastView()
        .toastLoading(context, child, style: _style, markId: markId ?? "");
  }

  /// Delete toast
  /// [markId]: Identification of toast
  static dismiss({String markId}) => ToastView().dismiss(markId: markId);
}
