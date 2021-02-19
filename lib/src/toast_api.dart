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
}
