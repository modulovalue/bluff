import 'package:bluff/base/keys.dart';

import '../build_context.dart';
import '../html.dart' as html;
import '../resolve_url.dart';

enum ClickState {
  inactive,
  hover,
  active,
}

class Click with WidgetMixin {
  final String url;
  final Widget Function(BuildContext context, ClickState value) builder;
  final bool newTab;
  final Key? key;

  const Click({
    this.newTab = false,
    required this.url,
    required this.builder,
    this.key,
  });

  @override
  html.HtmlElement renderHtml(BuildContext context) {
    final result = html.AnchorElement();
    result.className = 'click';
    result.href = resolveUrl(context, url);
    if (newTab) {
      result.target = '_blank';
    }
    final inactive = builder(context, ClickState.inactive).render(context);
    final active = builder(context, ClickState.active).render(context);
    final hover = builder(context, ClickState.hover).render(context);
    inactive.className = inactive.className! + ' inactive';
    active.className = active.className! + ' active';
    hover.className = hover.className! + ' hover';
    result.childNodes.add(inactive);
    result.childNodes.add(active);
    result.childNodes.add(hover);

    return result;
  }
}
