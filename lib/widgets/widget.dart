import 'package:bluff/base/keys.dart';

import '../build_context.dart';
import '../html.dart' as html;
import 'media_query.dart';

typedef WidgetBuilder = Widget Function(BuildContext context);

typedef WidgetChildBuilder = Widget Function(BuildContext context, Widget child);

typedef WidgetValueBuilder<T> = Widget Function(BuildContext context, T value);

abstract class Widget {
  final Key? key;

  const Widget({this.key});

  html.HtmlElement render(BuildContext context) {
    final css = renderCss(context);
    final html = renderHtml(context);
    final k = this.key;
    if (k != null) {
      final media = MediaQuery.of(context);
      html.id = k.className + '-${media!.size.index}';
    }
    final key = context.createDefaultKey();
    html.className = html.className! + (html.className!.isEmpty ? '' : ' ') + key.className;
    if (css != null) context.styles[key.className] = css;
    return html;
  }

  html.HtmlElement renderHtml(BuildContext context);

  html.CssStyleDeclaration? renderCss(BuildContext context) => null;
}

abstract class StatelessWidget extends Widget {
  const StatelessWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  @override
  html.HtmlElement renderHtml(BuildContext context) => build(context).render(context);
}

abstract class InheritedWidget extends StatelessWidget {
  final Widget child;

  const InheritedWidget({
    required this.child,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => child;

  @override
  html.HtmlElement render(BuildContext context) {
    return super.render(context.withInherited(this));
  }
}

class Builder extends StatelessWidget {
  final WidgetBuilder builder;

  Builder({
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => builder(context);
}
