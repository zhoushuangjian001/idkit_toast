part of idkit_toast;

class ToastStyle with Diagnosticable {
  final Color bgColor;
  final Color maskColor;
  final TextStyle textStyle;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final ToastAlignment alignment;
  final ShapeBorder shape;

  const ToastStyle({
    this.bgColor,
    this.maskColor,
    this.textStyle,
    this.margin,
    this.padding,
    this.alignment = ToastAlignment.center,
    this.shape,
  });

  /// Default style
  static ToastStyle get defaultStyle => ToastStyle(
        maskColor: Colors.transparent,
        bgColor: Colors.grey[700],
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        margin: EdgeInsets.all(80),
        padding: EdgeInsets.all(10),
        alignment: ToastAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      );

  static ToastStyle mappingStyle(ToastStyle style) {
    if (style == null) return ToastStyle.defaultStyle;
    return ToastStyle(
      maskColor: style.maskColor ?? ToastStyle.defaultStyle.maskColor,
      bgColor: style.bgColor ?? ToastStyle.defaultStyle.bgColor,
      textStyle: style.textStyle ?? ToastStyle.defaultStyle.textStyle,
      margin: style.margin ?? ToastStyle.defaultStyle.margin,
      padding: style.padding ?? ToastStyle.defaultStyle.padding,
      alignment: style.alignment ?? ToastStyle.defaultStyle.alignment,
      shape: style.shape ?? ToastStyle.defaultStyle.shape,
    );
  }
}

enum ToastAlignment {
  top,
  center,
  bottom,
}
