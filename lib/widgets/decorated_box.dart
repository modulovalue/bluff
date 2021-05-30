import 'package:bluff/base/border_radius.dart';
import 'package:bluff/base/decoration.dart';
import 'package:bluff/base/image.dart';
import 'package:bluff/base/keys.dart';
import '../html.dart' as html;

import '../build_context.dart';
import '../resolve_url.dart';
import 'flex.dart';

class DecoratedBox with WidgetMixin {
  final Widget? child;
  final BoxDecoration? decoration;
  final Key? key;

  const DecoratedBox({
    this.child,
    this.decoration,
    this.key,
  });

  @override
  html.CssStyleDeclaration renderCss(BuildContext context) {
    final style = html.DivElement().style;
    style.display = 'flex';

    if (decoration?.color != null) {
      final _color = decoration!.color!.toCss();
      style.backgroundColor = _color;
    } else if (decoration?.image != null) {
      style.backgroundImage = 'url(' + resolveUrl(context, decoration!.image!.image.url) + ')';
    }

    if (decoration != null) {
      if (decoration!.image?.fit != null) {
        style.backgroundPosition = 'center';
        switch (decoration!.image!.fit!) {
          case BoxFit.cover:
            style.backgroundSize = 'cover';
            break;
          case BoxFit.fill:
            style.backgroundSize = 'fill';
            break;
          case BoxFit.none:
            style.backgroundSize = 'none';
            break;
          case BoxFit.scaleDown:
            style.backgroundSize = 'scale-down';
            break;
          case BoxFit.contain:
            style.backgroundSize = 'contain';
            break;
        }
      }
      final borderRadius = decoration!.borderRadius;
      if (borderRadius is BorderRadius) {
        style.borderTopLeftRadius = '${borderRadius.topLeft.x}px';
        style.borderTopRightRadius = '${borderRadius.topRight.x}px';
        style.borderBottomLeftRadius = '${borderRadius.bottomLeft.x}px';
        style.borderBottomRightRadius = '${borderRadius.bottomRight.x}px';
      }

      if (decoration!.boxShadow.isNotEmpty) {
        final shadow = decoration!.boxShadow.first;
        final shadowColor = shadow.color.toCss();
        style.boxShadow =
            '${shadow.offset.dx}px ${shadow.offset}px ${shadow.blurRadius}px ${shadow.spreadRadius}px ${shadowColor};';
      }
    }
    return style;
  }

  @override
  html.HtmlElement renderHtml(BuildContext context) {
    final result = html.DivElement();
    if (child != null) {
      result.childNodes.add(Expanded(child: child!).render(context));
    }
    return result;
  }
}
