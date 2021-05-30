import 'package:bluff/base/image.dart';
import 'package:bluff/base/keys.dart';

import '../build_context.dart';
import '../html.dart' as html;
import '../resolve_url.dart';

class Image with WidgetMixin {
  final ImageProvider image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? semanticsLabel;
  final Key? key;

  const Image({
    required this.image,
    this.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.semanticsLabel,
  });

  Image.network(
    String url, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    String? semanticsLabel,
    Key? key,
  }) : this(
          key: key,
          fit: fit,
          width: width,
          height: height,
          semanticsLabel: semanticsLabel,
          image: ImageProvider.network(url),
        );

  Image.asset(
    String name, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    String? semanticsLabel,
    Key? key,
  }) : this(
          key: key,
          fit: fit,
          width: width,
          height: height,
          semanticsLabel: semanticsLabel,
          image: ImageProvider.asset(name),
        );

  @override
  html.CssStyleDeclaration renderCss(BuildContext context) {
    final style = html.DivElement().style;
    style.display = 'flex';
    if (width != null) style.width = '${width}px';
    if (height != null) style.height = '${height}px';
    switch (fit) {
      case BoxFit.cover:
        style.objectFit = 'cover';
        break;
      case BoxFit.fill:
        style.objectFit = 'fill';
        break;
      case BoxFit.none:
        style.objectFit = 'none';
        break;
      case BoxFit.scaleDown:
        style.objectFit = 'scale-down';
        break;
      case BoxFit.contain:
        style.objectFit = 'contain';
        break;
    }
    return style;
  }

  @override
  html.HtmlElement renderHtml(BuildContext context) {
    final result = html.ImageElement();
    result.src = resolveUrl(context, image.url);
    if (semanticsLabel != null) {
      result.alt = semanticsLabel;
    }
    return result;
  }
}
