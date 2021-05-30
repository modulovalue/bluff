import 'package:bluff/base/edge_insets.dart';
import 'package:bluff/base/keys.dart';
import '../html.dart' as html;

import '../build_context.dart';
import 'widget.dart';

class Padding extends Widget {
  final Widget? child;
  final EdgeInsets? padding;

  const Padding({
    this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

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
