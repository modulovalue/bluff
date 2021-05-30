import 'package:bluff/base/keys.dart';
import '../html.dart' as html;

import '../build_context.dart';

class SizedBox with WidgetMixin {
  final Widget? child;
  final double? width;
  final double? height;
  final Key? key;

  const SizedBox({
    this.child,
    this.width,
    this.height,
    this.key,
  });

  @override
  html.CssStyleDeclaration renderCss(BuildContext context) {
    final style = html.DivElement().style;
    if (width != null) style.width = '${width}px';
    if (height != null) style.height = '${height}px';
    style.flexShrink = '0';
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
