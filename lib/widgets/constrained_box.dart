import 'package:bluff/base/keys.dart';
import '../html.dart' as html;

import '../build_context.dart';
import 'widget.dart';

class ConstrainedBox extends Widget {
  /// The additional constraints to impose on the child.
  final BoxConstraints? constraints;
  final Widget? child;

  const ConstrainedBox({
    required this.child,
    this.constraints,
    Key? key,
  }) : super(key: key);

  @override
  html.CssStyleDeclaration renderCss(BuildContext context) {
    final style = html.DivElement().style;
    if (constraints != null) {
      style.margin = 'auto';
      style.maxHeight = '${constraints!.maxHeight}px';
      style.maxWidth = '${constraints!.maxWidth}px';
      style.minHeight = '${constraints!.minHeight}px';
      style.minWidth = '${constraints!.minWidth}px';
    }
    return style;
  }

  @override
  html.HtmlElement renderHtml(BuildContext context) {
    return child?.render(context) ?? html.DivElement();
  }
}

class BoxConstraints {
  /// The minimum width that satisfies the constraints.
  final double minWidth;

  /// The maximum width that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double maxWidth;

  /// The minimum height that satisfies the constraints.
  final double minHeight;

  /// The maximum height that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double maxHeight;

  BoxConstraints({
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
  });
}
