import 'package:bluff/base/keys.dart';

import '../build_context.dart';
import '../html.dart' as html;
import 'widget.dart';

enum ClickState {
  inactive,
  hover,
  active,
}

class Click extends Widget {
  final String url;
  final WidgetValueBuilder<ClickState> builder;
  final bool newTab;

  Click({
    this.newTab = false,
    required this.url,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  html.HtmlElement renderHtml(BuildContext context) {
    final result = html.AnchorElement();
    result.className = 'click';
    result.href = context.resolveUrl(url);
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
