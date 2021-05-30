import 'package:bluff/base/edge_insets.dart';
import 'package:bluff/base/keys.dart';
import '../html.dart' as html;

import '../build_context.dart';

class Padding with WidgetMixin {
  final Widget? child;
  final EdgeInsets? padding;
  final Key? key;

  const Padding({
    this.child,
    this.padding,
    this.key,
  });

  @override
  html.CssStyleDeclaration renderCss(BuildContext context) {
    final style = html.DivElement().style;
    style.display = 'flex';
    if (padding != null) {
      style.margin = '${padding!.top}px ${padding!.right}px ${padding!.bottom}px ${padding!.left}px';
    }
    return style;
  }

  @override
  html.HtmlElement renderHtml(BuildContext context) {
    if (child == null) {
      return html.DivElement();
    } else {
      return child!.render(context);
    }
  }
}
